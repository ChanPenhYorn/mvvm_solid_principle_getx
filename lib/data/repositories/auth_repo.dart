// lib/data/repositories/auth_repository_impl.dart
import 'package:getx_mvvm_architecture/data/datasources/auth_remote_ds.dart';
import 'package:getx_mvvm_architecture/domain/entities/user_entity.dart';

import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<UserEntity> login(String email, String password) async {
    final userModel = await remote.login(email, password);
    return userModel;
  }
}
