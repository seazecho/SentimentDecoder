import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeNotifier() {
    _loadTheme();
  }

  ThemeData get themeData => _isDarkMode
      ? ThemeData(
          brightness: Brightness.dark,
          primaryColor: const Color(0xFF0097A7),
          scaffoldBackgroundColor: const Color(0xFF121212),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF1A2525),
            titleTextStyle: TextStyle(
              color: Color(0xFF80DEEA),
              fontSize: 25,
            ),
            iconTheme: IconThemeData(color: Color(0xFFE0F7FA)),
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Color(0xFFE0F7FA)),
            bodyMedium: TextStyle(color: Color(0xFFB0BEC5)),
            titleLarge: TextStyle(color: Color(0xFF80DEEA)),
            headlineSmall: TextStyle(color: Color(0xFFE0F7FA)),
          ),
          iconTheme: const IconThemeData(color: Color(0xFFE0F7FA)),
          switchTheme: SwitchThemeData(
            thumbColor: MaterialStateProperty.all(const Color(0xFF80DEEA)),
            trackColor: MaterialStateProperty.all(const Color(0xFF37474F)),
          ),
          dividerTheme: const DividerThemeData(
            color: Color(0xFF37474F),
            thickness: 1,
          ),
          listTileTheme: const ListTileThemeData(
            textColor: Color(0xFFE0F7FA),
            iconColor: Color(0xFFE0F7FA),
            tileColor: Color(0xFF1A2525),
          ),
          snackBarTheme: const SnackBarThemeData(
            backgroundColor: Color(0xFF1A2525),
            contentTextStyle: TextStyle(color: Color(0xFFE0F7FA)),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color(0xFFE0F7FA),
              backgroundColor: const Color(0xFF0097A7),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFFE0F7FA),
              side: const BorderSide(color: Color(0xFF80DEEA)),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF80DEEA),
            ),
          ),
          dialogTheme: const DialogTheme(
            backgroundColor: Color(0xFF1A2525),
            titleTextStyle: TextStyle(color: Color(0xFFE0F7FA), fontSize: 20),
            contentTextStyle: TextStyle(color: Color(0xFFB0BEC5)),
          ),
          drawerTheme: const DrawerThemeData(
            backgroundColor: Color(0xFF121212),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: Color(0xFF1A2525),
            hintStyle: TextStyle(color: Color(0xFFB0BEC5)),
            labelStyle: TextStyle(color: Color(0xFFE0F7FA)),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF37474F)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF37474F)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF80DEEA)),
            ),
          ),
          colorScheme: ColorScheme.dark(
            primary: const Color(0xFF0097A7),
            secondary: const Color(0xFF00ABE4),
            surface: const Color(0xFF121212),
            onPrimary: const Color(0xFFE0F7FA),
            onSecondary: const Color(0xFFE0F7FA),
            onSurface: const Color(0xFFE0F7FA),
            error: Colors.redAccent,
            onError: const Color(0xFFE0F7FA),
          ),
        )
      : ThemeData(
          brightness: Brightness.light,
          primaryColor: const Color(0xFF0097A7),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            titleTextStyle: TextStyle(
              color: Color(0xFF0097A7),
              fontSize: 25,
            ),
            iconTheme: IconThemeData(color: Colors.black),
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.black87),
            bodyMedium: TextStyle(color: Colors.black54),
            titleLarge: TextStyle(color: Color(0xFF0097A7)),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          switchTheme: SwitchThemeData(
            thumbColor: MaterialStateProperty.all(const Color(0xFF0097A7)),
            trackColor: MaterialStateProperty.all(Colors.grey[300]),
          ),
          dividerColor: Colors.grey[300],
          listTileTheme: const ListTileThemeData(
            textColor: Colors.black87,
            iconColor: Colors.black,
          ),
          snackBarTheme: const SnackBarThemeData(
            backgroundColor: Colors.grey,
            contentTextStyle: TextStyle(color: Colors.black),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: const Color(0xFF0097A7),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF0097A7),
              side: const BorderSide(color: Color(0xFF0097A7)),
            ),
          ),
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF0097A7),
            secondary: Color(0xFF00ABE4),
            surface: Colors.white,
          ),
        );

  void toggleTheme(bool isDark) async {
    _isDarkMode = isDark;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', _isDarkMode);
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('darkMode') ?? false;
    notifyListeners();
  }
}
