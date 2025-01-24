import 'package:flutter/foundation.dart';

class AppConfig {
  final String baseUrl;
  // final String apiKey;
  // final bool isDebug;

  const AppConfig({
    required this.baseUrl,
    // required this.apiKey,
    // this.isDebug = false,
  });

  // Environment-specific configurations
  static AppConfig development = AppConfig(
    baseUrl: 'http://127.0.0.1:8000/api/',
    // apiKey: 'dev_api_key_123',
    // isDebug: true,
  );

  static AppConfig production = AppConfig(
    baseUrl: 'http://127.0.0.1:8000/api/',
    // apiKey: 'prod_api_key_456',
    // isDebug: false,
  );
}

class EnvironmentConfig {
  static AppConfig getCurrentConfig() {
    if (kDebugMode) {
      return AppConfig.development;
    }
    return AppConfig.production;
  }
}
