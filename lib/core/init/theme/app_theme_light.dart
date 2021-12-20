import 'package:flutter/material.dart';
import 'app_theme.dart';

class AppThemeLight extends AppTheme {
  static AppThemeLight? _instance;
  static AppThemeLight get instance {
    if (_instance == null) {
      _instance = AppThemeLight._init();
      return _instance!;
    }
    return _instance!;
  }

  @override
  ThemeData get theme => ThemeData(
        textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.black)),
        scaffoldBackgroundColor: const Color(0xFFe5f0f9),
        appBarTheme: const AppBarTheme(
          color: Color(0xFF639edc),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(primary: const Color(0xFF639edc))),
      );

  AppThemeLight._init();
}
