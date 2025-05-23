import 'package:bike_shop/core/controller/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AppBidding(),
      debugShowCheckedModeBanner: false,
      title: 'Bike Shop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SplashScreen(),
    );
  }
}

class AppBidding extends Bindings {
  @override
  void dependencies() {
    Get.put<MainController>(MainController());
  }
}
