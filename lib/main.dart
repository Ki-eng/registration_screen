import 'package:flutter/material.dart';
import 'package:registration_screen/screens/registration_screen.dart';
import 'package:registration_screen/theme/app_theme.dart';

void main() {
  runApp(const RegistrationApp());
}

class RegistrationApp extends StatelessWidget {
  const RegistrationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const RegistrationScreen(),
    );
  }
}
