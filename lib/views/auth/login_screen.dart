// lib/views/auth/login_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_architecture/controllers/auth_controller.dart';
import 'package:getx_mvvm_architecture/core/utils/logger_utils.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    // final authController = Get.put(AuthController(LoginUseCase()));

    final logger = LoggerUtils();

    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Obx(() {
        if (authController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email")),
            TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: "Password")),
            ElevatedButton(
              onPressed: () {
                authController.login(
                  emailController.text,
                  passwordController.text,
                );
                logger.log("Login button pressed");
              },
              child: Text("Login"),
            )
          ],
        );
      }),
    );
  }
}
