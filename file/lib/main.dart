import 'package:file/home.dart';
import 'package:file/seeting.dart';
import 'package:file/splash.dart'; // Assuming this is the correct path to your SplashScreen
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/home': (context) => HomePage(),
        '/settings': (context) => SettingsPage(),
      },
    );
  }
}