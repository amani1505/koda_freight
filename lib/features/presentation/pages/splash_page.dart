// lib/features/authentication/presentation/pages/splash_page.dart
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final authController = context.read<AuthController>();
    await Future.delayed(const Duration(seconds: 2));

    try {
      final isAuthenticated = await authController.checkAuthStatus();
      if (isAuthenticated) {
        // Navigate to home page
    
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        // Navigate to login page
        Navigator.of(context).pushReplacementNamed('/login');
      }
    } catch (e) {
      // Handle error, maybe show a dialog or navigate to login
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(size: 100),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
