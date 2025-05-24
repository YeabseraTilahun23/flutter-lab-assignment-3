import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reorderables/reorderables.dart';

import '../../data/models/album.dart';
import '../../data/models/photo.dart';
import '../blocs/album_bloc/album_bloc.dart';
import '../blocs/album_bloc/album_event.dart';
import '../blocs/album_bloc/album_state.dart';
import '../../core/widgets/loading_overlay.dart';
import '../../core/widgets/error_message.dart';
import '../../core/widgets/album_card.dart';

class AlbumListScreen extends StatefulWidget {
  const AlbumListScreen({super.key});

  @override
  State<AlbumListScreen> createState() => _AlbumListScreenState();
}

class _AlbumListScreenState extends State<AlbumListScreen> {
  List<Album> _albums = [];
  List<Photo> _photos = [];
  String _searchQuery = '';
  String _sortOption = 'title';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Premium Albums"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<AlbumBloc>().add(RefreshAlbumsEvent()),
          ),
          PopupMenuButton<String>(
            onSelected: (value) => setState(() => _sortOption = value),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'title', child: Text('Sort by Title')),
              const PopupMenuItem(value: 'id', child: Text('Sort by ID')),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<AlbumBloc, AlbumState>(
          builder: (context, state) {
            if (state is AlbumLoading) {
              return const LoadingOverlay();
            } else if (state is AlbumError) {
              return ErrorMessage(
                message: state.message,
                onRetry: () => context.read<AlbumBloc>().add(LoadAlbumsEvent()),
              );
            } else if (state is AlbumLoaded) {
              _albums = _applySortAndSearch(state.albums);
              _photos = state.photos;

              return Column(
                children: [
                  _buildSearchBar(),
                  Expanded(
                    child: ReorderableColumn(
                      scrollController: ScrollController(),
                      onReorder: _onReorder,
                      children: _albums.map((album) {
                        // Ensure safe selection of a photo even if none match this album.
                        Photo photo;
                        if (_photos.isEmpty) {
                          photo = Photo(
                              id: 0, albumId: album.id, title: 'No Photo', url: '', thumbnailUrl: '');
                        } else {
                          photo = _photos.firstWhere(
                            (p) => p.albumId == album.id,
                            orElse: () => _photos.first,
                          );
                        }
                        return AlbumCard(
                          key: ValueKey(album.id),
                          album: album,
                          photo: photo,
                          onTap: () => context.push('/album/${album.id}'),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      final item = _albums.removeAt(oldIndex);
      _albums.insert(newIndex, item);
    });
  }

  List<Album> _applySortAndSearch(List<Album> original) {
    var filtered = original
        .where((a) => a.title.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
    if (_sortOption == 'title') {
      filtered.sort((a, b) => a.title.compareTo(b.title));
    } else {
      filtered.sort((a, b) => a.id.compareTo(b.id));
    }
    return filtered;
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        decoration: const InputDecoration(
          hintText: "Search Albums...",
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
        onChanged: (val) => setState(() => _searchQuery = val),
      ),
    );
  }
}
