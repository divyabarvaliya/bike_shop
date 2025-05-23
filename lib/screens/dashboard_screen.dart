import 'package:bike_shop/core/constants/assets.dart';
import 'package:bike_shop/core/constants/colors.dart';
import 'package:bike_shop/core/constants/dimens.dart';
import 'package:bike_shop/core/controller/main_controller.dart';
import 'package:bike_shop/screens/cart_screen.dart';
import 'package:bike_shop/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          Obx(() => pageView()),
          Positioned(
            bottom: 0,
            child: Container(
              width: Dimens.screenWidth,
              height: Dimens.verticalBlockSize * 11,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImagesAsset.bottomBac),
                  fit: BoxFit.fill,
                ),
              ),
              child: Obx(
                () => Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedPositioned(
                      left:
                          Dimens.horizontalBlockSize *
                          MainController.to.left.value,
                      top: 0,
                      bottom: 0,
                      duration: Duration(milliseconds: 400),
                      child: Container(
                        height: Dimens.verticalBlockSize * 5,
                        width: Dimens.s_100(),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(ImagesAsset.selecBox),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimens.s_25()),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          MainController.to.iconList.length,
                          (i) => InkWell(
                            onTap: () {
                              _changeBoxPos(i);
                              MainController.to.selIn.value = i;
                            },
                            child: AnimatedPadding(
                              duration: Duration(milliseconds: 400),
                              padding: EdgeInsets.only(
                                bottom:
                                    MainController.to.selIn.value == i
                                        ? Dimens.verticalBlockSize * 4
                                        : 0,
                              ),
                              child: Image.asset(
                                MainController.to.iconList[i],
                                scale: 3.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget pageView() {
    switch (MainController.to.selIn.value) {
      case 0:
        return HomeScreen();
      case 1:
        return HomeScreen();
      case 2:
        return CartScreen();
      case 3:
        return HomeScreen();
      case 4:
        return HomeScreen();
      default:
        return HomeScreen();
    }
  }

  _changeBoxPos(int i) {
    if (i == 0) {
      MainController.to.left.value = -1.5;
    } else if (i == 1) {
      MainController.to.left.value = 20;
    } else if (i == 2) {
      MainController.to.left.value = 40.0;
    } else if (i == 3) {
      MainController.to.left.value = 60.0;
    } else if (i == 4) {
      MainController.to.left.value = 78.0;
    }
  }
}
