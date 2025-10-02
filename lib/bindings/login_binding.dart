import 'package:get/get.dart';
import 'package:getx_mvvm_architecture/controllers/auth_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
