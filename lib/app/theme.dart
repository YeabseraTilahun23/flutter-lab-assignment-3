import 'package:flutter/material.dart';

final ThemeData premiumLightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Bentham',
  scaffoldBackgroundColor: const Color(0xFFFAF5F0),
  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xFF8C1C13), 
    titleTextStyle: TextStyle(
      fontFamily: 'CinzelDecorative',
      fontSize: 20,
      color: Colors.white,
    ),
    centerTitle: true,
  ),
  colorScheme: ColorScheme.light(
    primary: const Color(0xFF8C1C13),
    secondary: const Color(0xFFD4AF37), 
  ),
);

final ThemeData premiumDarkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'Bentham',
  scaffoldBackgroundColor: const Color(0xFF1C1C1C),
  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xFFD4AF37), 
    titleTextStyle: TextStyle(
      fontFamily: 'CinzelDecorative',
      fontSize: 20,
      color: Colors.black,
    ),
    centerTitle: true,
  ),
  colorScheme: ColorScheme.dark(
    primary: const Color(0xFFD4AF37),
    secondary: const Color(0xFF8C1C13),
  ),
);
