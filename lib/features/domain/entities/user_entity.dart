// lib/features/authentication/domain/entities/user_entity.dart
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String username;
  final String email;
  final String token;
  final String? firstName;
  final String? lastName;
  final String? profileImageUrl;
  final List<String> roles;

  const UserEntity({
    required this.id,
    required this.username,
    required this.email,
    required this.token,
    this.firstName,
    this.lastName,
    this.profileImageUrl,
    this.roles = const [],
  });

  // Factory constructor from JSON
  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      token: json['token'] as String,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      profileImageUrl: json['profile_image'] as String?,
      roles: List<String>.from(json['roles'] ?? []),
    );
  }

  // Convert to JSON for storage or API calls
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'token': token,
      'first_name': firstName,
      'last_name': lastName,
      'profile_image': profileImageUrl,
      'roles': roles,
    };
  }

  // Equatable props for comparison
  @override
  List<Object?> get props => [
    id, 
    username, 
    email, 
    token, 
    firstName, 
    lastName, 
    profileImageUrl
  ];

  // Optional: Additional helper methods
  String get fullName => '$firstName $lastName'.trim();
  bool get hasProfileImage => profileImageUrl != null && profileImageUrl!.isNotEmpty;
}