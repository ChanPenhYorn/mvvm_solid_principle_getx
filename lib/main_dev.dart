import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_architecture/app.dart';
import 'package:getx_mvvm_architecture/core/utils/app_logger.dart';
import 'package:getx_mvvm_architecture/core/utils/app_translation.dart';
import 'controllers/theme_controller.dart';
import 'flavors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  Get.put(ThemeController());
  AppTranslation translations = AppTranslation();
  translations.loadTranslations();
  F.appFlavor = Flavor.dev;

  AppLogger.log("Run on Dev Environment");
  runApp(App(translations: translations));
}
