import 'package:flutter/material.dart';

class Dimens {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double horizontalBlockSize;
  static late double verticalBlockSize;
  static late double appBarHeight;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    horizontalBlockSize = screenWidth / 100;
    verticalBlockSize = screenHeight / 100;
    appBarHeight = AppBar().preferredSize.height;
  }

  static s_385() {
    return horizontalBlockSize * 106.953; //385
  }

  static s_300() {
    return horizontalBlockSize * 86; //300
  }

  static s_275() {
    return horizontalBlockSize * 75; //250
  }

  static s_250() {
    return horizontalBlockSize * 69.45; //250
  }

  static s_200() {
    return horizontalBlockSize * 57; //200
  }

  static s_140() {
    return horizontalBlockSize * 38; //150
  }

  static s_150() {
    return horizontalBlockSize * 43; //150
  }

  static s_120() {
    return horizontalBlockSize * 33.344; //120
  }

  static s_110() {
    return horizontalBlockSize * 30.562; //110
  }

  static s_100() {
    return horizontalBlockSize * 27.78; //100
  }

  static s_90() {
    return horizontalBlockSize * 25.008; //90
  }

  static s_82() {
    return horizontalBlockSize * 22.4; //82
  }

  static s_80() {
    return horizontalBlockSize * 20.514; //80
  }

  static s_75() {
    return horizontalBlockSize * 20.85; //75
  }

  static s_70() {
    return horizontalBlockSize * 19; //70
  }

  static s_60() {
    return horizontalBlockSize * 16.672; //60
  }

  static s_55() {
    return horizontalBlockSize * 15.281; //55
  }

  static s_50() {
    return horizontalBlockSize * 13.89; //50
  }

  static s_48() {
    return horizontalBlockSize * 13.38; //48
  }

  static s_45() {
    return horizontalBlockSize * 12.51; //45
  }

  static s_40() {
    return horizontalBlockSize * 10.257; //40
  }

  static s_38() {
    return horizontalBlockSize * 11; //38
  }

  static s_34() {
    return horizontalBlockSize * 9.5; //34
  }

  static s_30() {
    return horizontalBlockSize * 8.336; //30
  }

  static s_35() {
    return horizontalBlockSize * 9.750; //35
  }

  static s_36() {
    return horizontalBlockSize * 9.995; //36
  }

  static s_28() {
    return horizontalBlockSize * 7; //28
  }

  static s_25() {
    return horizontalBlockSize * 6.945; //25
  }

  static s_24() {
    return horizontalBlockSize * 6.690; //24
  }

  static s_20() {
    return horizontalBlockSize * 5.560; //20
  }

  static s_18() {
    return horizontalBlockSize * 5.0; //18
  }

  static s_17() {
    return horizontalBlockSize * 4.75; //18
  }

  static s_16() {
    return horizontalBlockSize * 4.450; //16
  }

  static s_15() {
    return horizontalBlockSize * 4.170; //15
  }

  static s_14() {
    return horizontalBlockSize * 3.900; //14
  }

  static s_11() {
    return horizontalBlockSize * 3.06; //11
  }

  static s_12() {
    return horizontalBlockSize * 3.360; //12
  }

  static s_13() {
    return horizontalBlockSize * 3.637; //13
  }

  static s_10() {
    return horizontalBlockSize * 2.800; //10
  }

  static s_8() {
    return horizontalBlockSize * 2.245; //8
  }

  static s_6() {
    return horizontalBlockSize * 1.685; //6
  }

  static s_4() {
    return horizontalBlockSize * 1.120; //4
  }

  static s_3() {
    return horizontalBlockSize * 0.8425; //6
  }

  static s_2() {
    return horizontalBlockSize * 0.560; //4
  }
}
