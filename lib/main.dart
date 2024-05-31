import 'package:flutter/material.dart';
import 'package:flutter_day_28/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/app_constants.dart';
import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    AppConstants.getTheme().then((_) => setState(() {}));
    AppConstants.getTextSize().then((_) => setState(() {}));
    AppConstants.getBackgroundImage().then((_) => setState(() {}));
  }

  void switchTheme(bool value) async {
    AppConstants.themeMode = value ? ThemeMode.dark : ThemeMode.light;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDark', value);
    setState(() {});
  }

  void setTextSize(double textSize) async {
    AppConstants.textSize = textSize;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('textSize', textSize);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: AppConstants.themeMode,
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: PageView(
        children: [
          const HomeScreen(),
          SettingsScreen(
            onThemeChanged: switchTheme,
            onTextSizeChanged: setTextSize,
          ),
        ],
      ),
    );
  }
}
