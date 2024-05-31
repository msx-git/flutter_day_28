import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConstants {
  static ThemeMode themeMode = ThemeMode.light;

  static String backgroundImage =
      "https://mfiles.alphacoders.com/101/thumb-1920-1013875.png";
  static Color backgroundColor = Colors.teal;
  static double textSize = 14;
  static Color textColor = Colors.deepPurple;

  static Future<void> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDark = prefs.getBool('isDark') ?? false;
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  static Future<void> getTextSize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    textSize = prefs.getDouble('textSize') ?? 14;
  }

  //https://i.pinimg.com/originals/a2/92/bb/a292bbb8a8df4680e0c71ce0cde42417.gif

  static Future<void> getBackgroundImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    backgroundImage = prefs.getString('backgroundImage') ??
        "https://i.pinimg.com/736x/b1/4a/23/b14a235e92874a9d196c7c9bb4773402.jpg";
  }
}
