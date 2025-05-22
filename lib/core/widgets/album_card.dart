import 'package:flutter/material.dart';
import '../../data/models/album.dart';
import '../../data/models/photo.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AlbumCard extends StatelessWidget {
  final Album album;
  final Photo photo;
  final VoidCallback onTap;

  const AlbumCard({
    super.key,
    required this.album,
    required this.photo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(photo.thumbnailUrl),
        ),
        title: Text(album.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.drag_handle),
      ),
    );
  }
}
