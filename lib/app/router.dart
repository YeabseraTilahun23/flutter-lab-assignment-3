import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'album/lib/presentation/screens/album_list_screen.dart';
import 'album/lib/presentation/screens/album_detail_screen.dart';

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
        final albumId = int.parse(state.params['id']!);
        return AlbumDetailScreen(albumId: albumId);
      },
    ),
  ],
);
