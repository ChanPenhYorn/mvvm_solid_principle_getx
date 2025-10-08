// lib/controllers/auth_controller.dart
import 'package:get/get.dart';
import 'package:getx_mvvm_architecture/core/utils/logger_utils.dart';
import 'package:getx_mvvm_architecture/domain/usecases/auth_usecase.dart';
import 'package:getx_mvvm_architecture/domain/entities/user_entity.dart';

class AuthController extends GetxController {
  final AuthUseCase loginUseCase;
  AuthController(this.loginUseCase);

  // final AuthUseCase loginUseCase = AuthUseCase();
  final LoggerUtils logger = LoggerUtils();

  var isLoading = false.obs;
  var user = Rxn<UserEntity>();

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    logger.log("controller login run");
    user.value = await loginUseCase.login(email, password);
    isLoading.value = false;
  }
}
