// lib/features/authentication/presentation/pages/login_page.dart
import 'package:flutter/material.dart';
import 'package:koda_freight/features/presentation/controllers/auth_controller.dart';
import 'package:koda_freight/features/presentation/widgets/login_form.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Consumer<AuthController>(
            builder: (context, authController, child) {
              return LoginForm(
                onLogin: (username, password) async {
                  try {
                    await authController.login(username, password);
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushReplacementNamed('/home');
                  } catch (e) {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString())),
                    );
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}