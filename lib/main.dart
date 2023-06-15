import 'package:calculator/screens/calculator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Colors.white,
          onPrimary: Colors.white,
          secondary: Color.fromRGBO(70, 70, 70, 1),
          onSecondary: Colors.white,
          error: Colors.white,
          onError: Colors.white,
          background: Colors.white,
          onBackground: Colors.white,
          surface: Colors.white,
          onSurface: Colors.white,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          background: Color.fromRGBO(68, 68, 68, 1),
          primary: Colors.white,
          // secondary: Color.fromRGBO(68, 68, 68, 1),
          secondary: Color.fromRGBO(250, 250, 250, 1),
          onBackground: Color.fromRGBO(68, 68, 68, 1),
        ),
      ),
      themeMode: ThemeMode.system,
      home: const Calculator(),
    );
  }
}
