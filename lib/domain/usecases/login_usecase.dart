// lib/domain/usecases/login_usecase.dart
import 'package:getx_mvvm_architecture/core/utils/logger_utils.dart';

import '../repositories/auth_repository.dart';
import '../entities/user_entity.dart';

class LoginUseCase implements AuthRepository {
  // final AuthRepository repository;
  // LoginUseCase(this.repository);

  final LoggerUtils logger = LoggerUtils();

  @override
  Future<UserEntity> login(String email, String password) {
    logger.log("usecase login run");
    // return throw UnimplementedError();
    return Future<UserEntity>.value(
        UserEntity(id: "1", name: "name", email: "email"));
  }
}
