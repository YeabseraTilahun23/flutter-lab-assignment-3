import 'package:http/http.dart' as http;
import '../models/album.dart';
import '../models/photo.dart';
import '../providers/album_api.dart';

class AlbumRepository {
  final AlbumApiProvider apiProvider;

  AlbumRepository({http.Client? client})
      : apiProvider = AlbumApiProvider(client: client ?? http.Client());

  Future<List<Album>> getAlbums() => apiProvider.fetchAlbums();

  Future<List<Photo>> getPhotos() => apiProvider.fetchPhotos();
}
