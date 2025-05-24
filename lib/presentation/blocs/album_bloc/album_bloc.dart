import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/album.dart';
import '../../../data/models/photo.dart';
import '../../../data/repositories/album_repository.dart';
import 'album_event.dart';
import 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final AlbumRepository repository;

  AlbumBloc({AlbumRepository? albumRepository})
      : repository = albumRepository ?? AlbumRepository(),
        super(AlbumInitial()) {
    on<LoadAlbumsEvent>(_onLoadAlbums);
    on<RefreshAlbumsEvent>(_onRefreshAlbums);
  }

  Future<void> _onLoadAlbums(LoadAlbumsEvent event, Emitter<AlbumState> emit) async {
    emit(AlbumLoading());
    try {
      final albums = await repository.getAlbums();
      final photos = await repository.getPhotos();
      emit(AlbumLoaded(albums: albums, photos: photos));
    } catch (e) {

      emit(AlbumError('Failed to fetch albums: ${e.toString()}'));
    }
  }

  Future<void> _onRefreshAlbums(RefreshAlbumsEvent event, Emitter<AlbumState> emit) async {
   
    add(LoadAlbumsEvent());
  }
}
