import 'package:flutter/material.dart';
import 'package:registration_screen/controllers/controller.dart';
import 'package:registration_screen/screens/login_screen.dart';
import 'package:registration_screen/widgets/app_logo.dart';
import 'package:registration_screen/widgets/app_text_field.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _controller = Controller();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // validate everything, never proceed when invalid
  void _handleRegister() {
    FocusScope.of(context).unfocus();

    // field errors show inline
    if (!_controller.validateForm()) return;

    if (!_controller.termsAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please accept the Terms & Conditions')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Account created for ${_controller.nameController.text.trim()}!',
        ),
      ),
    );
  }

  // one builder for both password fields
  Widget _passwordField({required bool isConfirm}) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) {
        return AppTextField(
          controller: isConfirm
              ? _controller.confirmPasswordController
              : _controller.passwordController,
          label: isConfirm ? 'Confirm Password' : 'Password',
          hint: isConfirm ? 'Re-enter your password' : 'Create a password',
          prefixIcon: Icons.lock_outline,
          obscureText: isConfirm
              ? _controller.obscureConfirm
              : _controller.obscurePassword,
          validator: isConfirm
              ? _controller.validateConfirm
              : _controller.validatePassword,
          suffixIcon: IconButton(
            icon: Icon(
              (isConfirm
                      ? _controller.obscureConfirm
                      : _controller.obscurePassword)
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
            ),
            onPressed: isConfirm
                ? _controller.toggleConfirm
                : _controller.togglePassword,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          // scrollable, keyboard-safe
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Form(
                key: _controller.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // heading & welcome
                    const AppLogo(),
                    const SizedBox(height: 24),
                    const Text(
                      'Create Your Account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Fill in your details to get started',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 32),

                    //  input fields
                    AppTextField(
                      controller: _controller.nameController,
                      label: 'Full Name',
                      hint: 'Enter your full name',
                      prefixIcon: Icons.person_outline,
                      validator: _controller.validateName,
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      controller: _controller.emailController,
                      label: 'Email',
                      hint: 'Enter your email',
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: _controller.validateEmail,
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      controller: _controller.phoneController,
                      label: 'Phone Number',
                      hint: 'e.g. 1234567890',
                      prefixIcon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      validator: _controller.validatePhone,
                    ),
                    const SizedBox(height: 16),
                    _passwordField(isConfirm: false),
                    const SizedBox(height: 16),
                    _passwordField(isConfirm: true),
                    const SizedBox(height: 16),

                    // gender selection
                    ListenableBuilder(
                      listenable: _controller,
                      builder: (context, _) {
                        return DropdownButtonFormField<String>(
                          value: _controller.gender,
                          decoration: const InputDecoration(
                            labelText: 'Gender',
                            prefixIcon: Icon(Icons.wc_outlined),
                          ),
                          items: Controller.genderOptions
                              .map(
                                (g) =>
                                    DropdownMenuItem(value: g, child: Text(g)),
                              )
                              .toList(),
                          onChanged: _controller.setGender,
                          validator: (value) => value == null
                              ? 'Please select your gender'
                              : null,
                        );
                      },
                    ),
                    const SizedBox(height: 8),

                    // Terms & Conditions
                    ListenableBuilder(
                      listenable: _controller,
                      builder: (context, _) {
                        return GestureDetector(
                          onTap: () => _controller.toggleTerms(),
                          child: Row(
                            children: [
                              Checkbox(
                                value: _controller.termsAccepted,
                                onChanged: (v) => _controller.toggleTerms(v),
                              ),
                              Expanded(
                                child: Text(
                                  'I accept the Terms & Conditions',
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),

                    // Register button
                    ElevatedButton(
                      onPressed: _handleRegister,
                      child: const Text('Register'),
                    ),
                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?'),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text('Login'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
