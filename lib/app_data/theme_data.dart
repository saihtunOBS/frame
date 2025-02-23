import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    useMaterial3: false,
    bottomNavigationBarTheme:  BottomNavigationBarThemeData(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey.withOpacity(0.9)),
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent, foregroundColor: Colors.black)
    // Define additional light theme properties here
    );
final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.grey[900],
    useMaterial3: false,
    bottomNavigationBarTheme:  BottomNavigationBarThemeData(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.withOpacity(0.9)),
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent, foregroundColor: Colors.white)
    // Define additional dark theme properties here
    );
