import 'package:flutter/material.dart';

class Controller extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  static const genderOptions = ['Male', 'Female', 'Other'];

  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _termsAccepted = false;
  String? _gender;
  bool _rememberMe = false;

  bool get obscurePassword => _obscurePassword;
  bool get obscureConfirm => _obscureConfirm;
  bool get termsAccepted => _termsAccepted;
  String? get gender => _gender;
  bool get rememberMe => _rememberMe;

  // Validate Name
  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Full name is required';
    }
    if (value.trim().length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  }

  // Validate Email

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  }

  // Validate Phone Number

  String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    final phoneRegex = RegExp(r'^\d{7,15}$'); // digits only, 7–15 long
    if (!phoneRegex.hasMatch(value.trim())) {
      return 'Enter a valid phone number (7–15 digits)';
    }
    return null;
  }

  // Validate Password

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  // Validate Confirm Password

  String? validateConfirm(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Toggle Password Visibility

  void togglePassword() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  // Toggle Confirm Password Visibility

  void toggleConfirm() {
    _obscureConfirm = !_obscureConfirm;
    notifyListeners();
  }

  // Toggle Terms and Conditions

  void toggleTerms([bool? value]) {
    _termsAccepted = value ?? !_termsAccepted;
    notifyListeners();
  }

  // Set Gender

  void setGender(String? value) {
    _gender = value;
    notifyListeners();
  }

  // Toggle remember me check box

  void toggleRememberMe([bool? value]) {
    _rememberMe = value ?? !_rememberMe;
    notifyListeners();
  }

  /// Validates every field. True only when all are valid.
  bool validateForm() => formKey.currentState?.validate() ?? false;

  bool login() => formKey.currentState?.validate() ?? false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
