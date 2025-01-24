// lib/services/api_service.dart
import 'package:dio/dio.dart';
import '../app/config/app_config.dart';

class ApiService {
  final Dio _dio;
  final AppConfig _config;

  ApiService(this._config) : _dio = Dio() {
    _initializeDio();
  }

  void _initializeDio() {
    _dio.options.baseUrl = _config.baseUrl;
    _dio.options.headers['Authorization'] = 'Bearer ooopp';
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);

    // Add interceptors for logging, error handling, etc.
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Add any request preprocessing
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // Add any response preprocessing
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        // Handle errors globally
        return handler.next(e);
      },
    ));
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) {
    return _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data}) {
    return _dio.post(path, data: data);
  }

  // Add other HTTP methods as needed
}