import 'package:flutter/material.dart';

class Bubble {
  String text;
  double scale;
  Color activeColor;
  Color inactiveColor;
  TextStyle textStyle;

  Bubble({
    required this.text,
    this.scale = 1,
    this.activeColor = const Color.fromARGB(128, 244, 67, 54),
    this.inactiveColor = const Color.fromARGB(128, 33, 149, 243),
    this.textStyle = const TextStyle(
      fontSize: 18,
    ),
  }) : assert(
          scale >= 0 && scale <= 1,
        );
}
