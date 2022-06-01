import 'package:flutter/material.dart';
import 'pages/home.dart';

var lightColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF0077FF),
  brightness: Brightness.light,
);
var darkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF0077FF),
  brightness: Brightness.dark,
);

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Space Insider Preview',
      themeMode: ThemeMode.system,
      theme: ThemeData.light().copyWith(
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: darkColorScheme,
      ),
      home: const HomePage(),
    );
  }
}

