import 'package:dio/dio.dart';
import 'package:koda_freight/features/authentication/datasources/auth_remote_datasource.dart';
import 'package:koda_freight/features/domain/entities/user_entity.dart';


class AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepository(this._remoteDataSource);

  Future<UserEntity> login(String username, String password) async {
    try {
      final response = await _remoteDataSource.login(username, password);
      return UserEntity.fromJson(response.data);
    } on DioException catch (e) {
      throw AuthenticationException(e.message ?? 'Login failed');
    }
  }

  Future<void> logout() async {
    await _remoteDataSource.logout();
  }
}

class AuthenticationException implements Exception {
  final String message;
  
  AuthenticationException(this.message);
}