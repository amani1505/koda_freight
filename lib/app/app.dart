// lib/app/routes/app_router.dart
import 'package:flutter/material.dart';
import 'package:koda_freight/features/presentation/pages/login_page.dart';
import 'package:koda_freight/features/presentation/pages/splash_page.dart';

class AppRouter {
  static final Map<String, WidgetBuilder> routes = {
    '/splash': (context) => const SplashPage(),
    '/login': (context) => const LoginPage(),
    '/home': (context) => const HomePage(), // Add your home page here
  };

  // Optional: Named route navigation method
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/splash':
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomePage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}

// Placeholder HomePage (you'll want to implement this)
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(child: Text('Welcome to the Home Page')),
    );
  }
}
