// lib/domain/usecases/login_usecase.dart
import 'package:getx_mvvm_architecture/core/utils/logger_utils.dart';
import 'package:getx_mvvm_architecture/data/repositories/auth_repo.dart';

import '../repositories/auth_repo.dart';
import '../entities/user_entity.dart';

class AuthUseCase implements AuthRepository {
  final AuthRepositoryImpl repository;
  AuthUseCase(this.repository);

  final LoggerUtils logger = LoggerUtils();

  @override
  Future<UserEntity> login(String email, String password) {
    logger.log("usecase login run");
    // return throw UnimplementedError();
    return repository.login(email, password);
  }
}
