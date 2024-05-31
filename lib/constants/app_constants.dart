import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConstants {
  static ThemeMode themeMode = ThemeMode.light;

  static String backgroundImage = "";
  static double textSize = 16;
  static Color textColor = Colors.deepPurple;

  static Future<void> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDark = prefs.getBool('isDark') ?? false;
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  static Future<void> getTextSize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    textSize = prefs.getDouble('textSize') ?? 16;
  }

  static Future<void> getTextColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    textColor = Color(prefs.getInt('textColor') ?? 4278190080);
  }

  static Future<void> getBackgroundImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    backgroundImage = prefs.getString('backgroundImage') ??
        "https://i.pinimg.com/736x/b1/4a/23/b14a235e92874a9d196c7c9bb4773402.jpg";
  }
}
