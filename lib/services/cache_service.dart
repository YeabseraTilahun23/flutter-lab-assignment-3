import 'package:hive/hive.dart';
import '../data/models/album.dart';
import '../data/models/photo.dart';

class CacheService {
  final _albumBox = Hive.box('albums');
  final _photoBox = Hive.box('photos');

  void cacheAlbums(List<Album> albums) {
    final data = albums.map((a) => {'id': a.id, 'title': a.title}).toList();
    _albumBox.put('albums', data);
  }

  void cachePhotos(List<Photo> photos) {
    final data = photos.map((p) => {
      'id': p.id,
      'albumId': p.albumId,
      'title': p.title,
      'url': p.url,
      'thumbnailUrl': p.thumbnailUrl
    }).toList();
    _photoBox.put('photos', data);
  }

  List<Album> getCachedAlbums() {
    final data = _albumBox.get('albums') ?? [];
    return List<Album>.from(data.map((a) => Album(id: a['id'], title: a['title'])));
  }

  List<Photo> getCachedPhotos() {
    final data = _photoBox.get('photos') ?? [];
    return List<Photo>.from(data.map((p) => Photo(
      id: p['id'],
      albumId: p['albumId'],
      title: p['title'],
      url: p['url'],
      thumbnailUrl: p['thumbnailUrl'],
    )));
  }
}
