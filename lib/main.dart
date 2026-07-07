import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';

void main() {
  runApp(const SignagePlayerApp());
}

class SignagePlayerApp extends StatelessWidget {
  const SignagePlayerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digital Signage Player',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      home: const SplashScreen(),
    );
  }
}
