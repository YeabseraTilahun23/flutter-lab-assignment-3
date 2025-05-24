import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../../data/models/album.dart';
import '../../../data/models/photo.dart';
import '../../../data/repositories/album_repository.dart';
import 'album_event.dart';
import 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final AlbumRepository repository;
  final Box hiveBox = Hive.box('albumsBox'); 

  AlbumBloc({AlbumRepository? albumRepository})
      : repository = albumRepository ?? AlbumRepository(),
        super(AlbumInitial()) {
    on<LoadAlbumsEvent>(_onLoadAlbums);
    on<RefreshAlbumsEvent>(_onRefreshAlbums);
  }

  Future<void> _onLoadAlbums(LoadAlbumsEvent event, Emitter<AlbumState> emit) async {
    emit(AlbumLoading());

    try {
      List<Album>? cachedAlbums = hiveBox.get('albums');
      List<Photo>? cachedPhotos = hiveBox.get('photos');

      if (cachedAlbums != null && cachedPhotos != null) {
        emit(AlbumLoaded(albums: cachedAlbums, photos: cachedPhotos));
        return; 
      }

      final albums = await repository.getAlbums();
      final photos = await repository.getPhotos();

      hiveBox.put('albums', albums);
      hiveBox.put('photos', photos);

      emit(AlbumLoaded(albums: albums, photos: photos));
    } catch (e) {
      emit(AlbumError('Failed to fetch albums: ${e.toString()}'));
    }
  }

  Future<void> _onRefreshAlbums(RefreshAlbumsEvent event, Emitter<AlbumState> emit) async {
    hiveBox.delete('albums');
    hiveBox.delete('photos');

    add(LoadAlbumsEvent());
  }
}
