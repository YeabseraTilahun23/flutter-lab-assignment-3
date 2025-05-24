import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/router.dart';
import 'app/theme.dart';
import 'presentation/blocs/album_bloc/album_bloc.dart';
import 'presentation/blocs/album_bloc/album_event.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('albumsBox');
  runApp(const AlbumApp());
}

class AlbumApp extends StatefulWidget {
  const AlbumApp({Key? key}) : super(key: key);

  @override
  State<AlbumApp> createState() => _AlbumAppState();
}

class _AlbumAppState extends State<AlbumApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AlbumBloc()..add(const LoadAlbumsEvent()),
      child: MaterialApp.router(
        title: 'Premium Albums',
        theme: premiumLightTheme,
        darkTheme: premiumDarkTheme,
        themeMode: _themeMode,
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
