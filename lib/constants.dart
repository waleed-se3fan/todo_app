import 'package:flutter/material.dart';

final _appColorScheme = const ColorScheme.dark().copyWith(
  background: const Color(0xFF0A0E20),
  primary: Colors.teal,
  surface: const Color(0xFF1D1E30),
  surfaceVariant: const Color(0xFF4C4F5E),
  onPrimary: Colors.white,
  onSurface: const Color(0xFF8D8E98),
);

const _fontFamily = 'Roboto';
final _appTextTheme = TextTheme(
  displayLarge: const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 64,
  ),
  displayMedium: const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 38,
    fontWeight: FontWeight.w900,
  ),
  labelMedium: TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    color: _appColorScheme.onSurface,
  ),
  headlineLarge: const TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w900,
    fontSize: 40,
  ),
  // AppBar title, dialog title
  titleSmall: const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 20,
  ),
  // Dialog text, hint text
  bodyMedium: const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
  ),
  // Dialog button
  bodySmall: const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
  ),
);

final appTheme = ThemeData.dark().copyWith(
  colorScheme: _appColorScheme,
  textTheme: _appTextTheme,
  backgroundColor: _appColorScheme.background,
  iconTheme: IconThemeData(color: _appColorScheme.onPrimary),
  hintColor: _appColorScheme.onSurface,
  appBarTheme: AppBarTheme(
    color: _appColorScheme.primary,
    titleTextStyle:
        _appTextTheme.bodyMedium?.copyWith(color: _appColorScheme.onPrimary),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle:
        _appTextTheme.bodyMedium?.copyWith(color: _appColorScheme.onSurface),
    border: const OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: _appColorScheme.primary,
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(primary: _appColorScheme.primary),
  ),
  listTileTheme: ListTileThemeData(tileColor: _appColorScheme.surface),
  dialogTheme: DialogTheme(
    backgroundColor: _appColorScheme.surface,
    titleTextStyle: _appTextTheme.titleSmall,
    contentTextStyle: _appTextTheme.bodyMedium,
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: _appColorScheme.surface,
    contentTextStyle:
        _appTextTheme.bodySmall?.copyWith(color: _appColorScheme.onBackground),
  ),
);


