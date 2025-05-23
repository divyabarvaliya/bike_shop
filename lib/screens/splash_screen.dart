import 'package:bike_shop/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';

import '../core/constants/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    goToNextPage();
  }

  Future<void> goToNextPage() async {
    await Future.delayed(Duration(seconds: 3));
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Dimens().init(context);
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Image.asset(ImagesAsset.bg_2),
          ),
          Image.asset(ImagesAsset.logo, scale: 4),
        ],
      ),
    );
  }
}
