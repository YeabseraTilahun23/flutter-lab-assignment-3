import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../presentation/screens/album_list_screen.dart';
import '../presentation/screens/album_detail_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AlbumListScreen(),
    ),
    GoRoute(
      path: '/album/:id',
      builder: (context, state) {
        final albumId = int.tryParse(state.pathParameters['id'] ?? '');
        if (albumId == null) {
          return const Scaffold(
            body: Center(child: Text('Invalid album ID')),
          );
        }
        return AlbumDetailScreen(albumId: albumId);
      },
    ),
  ],
);
