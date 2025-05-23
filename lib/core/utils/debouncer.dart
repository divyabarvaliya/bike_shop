import 'dart:async';

import 'package:flutter/material.dart';

class DeBouncer {
  final int milliSecond;
  VoidCallback? action;
  Timer? _timer;

  DeBouncer({required this.milliSecond});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliSecond), action);
  }
}
