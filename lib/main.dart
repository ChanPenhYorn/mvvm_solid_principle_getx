import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:getx_mvvm_architecture/core/utils/app_translation.dart';
import 'package:getx_mvvm_architecture/controllers/theme_controller.dart';

import 'app.dart';
import 'flavors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  Get.put(ThemeController());
  AppTranslation translations = AppTranslation();
  translations.loadTranslations();
  F.appFlavor = Flavor.values.firstWhere(
    (element) => element.name == appFlavor,
  );

  runApp(App(translations: translations));
}
