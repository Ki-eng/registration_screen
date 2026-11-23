// import 'package:flutter/material.dart';

// class LoginController extends ChangeNotifier {
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   bool _obscurePassword = true;
//   bool _rememberMe = false;

//   bool get obscurePassword => _obscurePassword;
//   bool get rememberMe => _rememberMe;

//   // ── State toggles ──
//   void togglePasswordVisibility() {
//     _obscurePassword = !_obscurePassword;
//     notifyListeners();
//   }

//   void toggleRememberMe([bool? value]) {
//     _rememberMe = value ?? !_rememberMe;
//     notifyListeners();
//   }

//   // ── Validation rules ──
//   String? validateEmail(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return 'Email is required';
//     }
//     final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
//     if (!emailRegex.hasMatch(value.trim())) {
//       return 'Enter a valid email address';
//     }
//     return null;
//   }

//   String? validatePassword(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Password is required';
//     }
//     if (value.length < 6) {
//       return 'Password must be at least 6 characters';
//     }
//     return null;
//   }

//   // Runs validation. Returns true when the form is valid.
//   bool login() => formKey.currentState?.validate() ?? false;

//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }
// }
