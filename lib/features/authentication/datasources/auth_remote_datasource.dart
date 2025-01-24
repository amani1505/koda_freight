// lib/features/authentication/data/datasources/auth_remote_datasource.dart
import 'package:dio/dio.dart';
import 'package:koda_freight/services/api_service.dart';

class AuthRemoteDataSource {
  final ApiService _apiService;

  AuthRemoteDataSource(this._apiService);

  Future<Response> login(String username, String password) async {
    try {
      final response = await _apiService.post('/auth/login', data: {
        'username': username,
        'password': password,
      });

      if (response.statusCode == 200) {
        return response;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Login failed',
        );
      }
    } on DioException catch (e) {
      throw DioException(
        requestOptions: e.requestOptions,
        response: e.response,
        message: e.message ?? 'An unexpected error occurred',
      );
    }
  }

  Future<void> logout() async {
    try {
      await _apiService.post('/auth/logout');
    } catch (e) {
      // Handle logout errors
      rethrow;
    }
  }

  Future<Response> refreshToken(String refreshToken) async {
    try {
      final response = await _apiService.post('/auth/refresh', data: {
        'refresh_token': refreshToken,
      });

      if (response.statusCode == 200) {
        return response;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Token refresh failed',
        );
      }
    } on DioException catch (e) {
      throw DioException(
        requestOptions: e.requestOptions,
        response: e.response,
        message: e.message ?? 'An unexpected error occurred',
      );
    }
  }
}
