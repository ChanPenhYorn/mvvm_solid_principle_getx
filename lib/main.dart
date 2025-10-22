import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_architecture/core/utils/app_logger.dart';
import 'package:getx_mvvm_architecture/core/utils/app_translation.dart';
import 'package:getx_mvvm_architecture/firebase_options_dev.dart'
    // ignore: library_prefixes
    as DefaultFirebaseOptionsDev;
import 'package:getx_mvvm_architecture/firebase_options_staging.dart'
    // ignore: library_prefixes
    as DefaultFirebaseOptionsStaging;
import 'package:getx_mvvm_architecture/firebase_options.dart'
    // ignore: library_prefixes
    as DefaultFirebaseOptionsProd;
import 'package:package_info_plus/package_info_plus.dart';
import 'app.dart';
import 'controllers/theme_controller.dart';
import 'flavors.dart';

void main() async {
  // 1. Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Set System UI (optional: status bar, orientation)
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  F.appFlavor = Flavor.values.firstWhere(
    (element) => element.name == appFlavor,
    orElse: () => Flavor.dev,
  );

  AppLogger.log("Flavor: ${F.appFlavor}");

  try {
    FirebaseApp firebaseApp;
    // 4. Initialize Firebase with flavor-specific options
    firebaseApp = await Firebase.initializeApp(
      options: F.appFlavor == Flavor.dev
          ? DefaultFirebaseOptionsDev.DefaultFirebaseOptions.currentPlatform
          : F.appFlavor == Flavor.staging
              ? DefaultFirebaseOptionsStaging
                  .DefaultFirebaseOptions.currentPlatform
              : DefaultFirebaseOptionsProd
                  .DefaultFirebaseOptions.currentPlatform,
    );

    //! Log Firebase info
    AppLogger.log("🔥 Firebase initialized successfully");
    AppLogger.log("App name: ${firebaseApp.name}");
    AppLogger.log("Firebase options:");
    AppLogger.log("  - Project ID: ${firebaseApp.options.projectId}");
    AppLogger.log("  - App ID: ${firebaseApp.options.appId}");
    AppLogger.log("  - API Key: ${firebaseApp.options.apiKey}");

    // 5. Pass uncaught errors to Crashlytics
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };

    // 6. Pass uncaught async errors to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    AppLogger.log('Firebase initialized for flavor: ${F.name}');
  } catch (e) {
    AppLogger.log('Failed to initialize Firebase');
    // Optionally: show error screen or fallback
  }

  // 7. Initialize GetX Controllers
  Get.put(ThemeController());
  AppTranslation translations = AppTranslation();
  translations.loadTranslations();

  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String bundleId = packageInfo.packageName;

  AppLogger.log("Run on Dev Environment");
  AppLogger.log("Dev Bundle ID: $bundleId");

  runApp(App(translations: translations));
}
