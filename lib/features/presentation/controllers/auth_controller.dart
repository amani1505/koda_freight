// lib/features/authentication/presentation/controllers/auth_controller.dart
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:koda_freight/features/authentication/datasources/auth_remote_datasource.dart';
import 'package:koda_freight/features/authentication/repositories/auth_repository.dart';
import 'package:koda_freight/features/domain/entities/user_entity.dart';
import 'package:koda_freight/services/api_service.dart';


class AuthController with ChangeNotifier {
  final ApiService _apiService;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  UserEntity? _currentUser;
  bool _isLoading = false;

  AuthController(this._apiService);

  UserEntity? get currentUser => _currentUser;
  bool get isLoading => _isLoading;

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final authRepository =
          AuthRepository(_apiService as AuthRemoteDataSource);
      final user = await authRepository.login(username, password);

      // Store authentication token
      await _secureStorage.write(key: 'auth_token', value: user.token);

      _currentUser = user;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      final authRepository =
          AuthRepository(_apiService as AuthRemoteDataSource);
      await authRepository.logout();

      // Clear stored token
      await _secureStorage.delete(key: 'auth_token');

      _currentUser = null;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> checkAuthStatus() async {
    final token = await _secureStorage.read(key: 'auth_token');
    return token != null;
  }

  Future<UserEntity?> getCurrentUser() async {
    if (_currentUser != null) return _currentUser;

    // Implement logic to fetch current user from API or local storage
    // This is a placeholder and should be replaced with actual implementation
    return null;
  }
}
