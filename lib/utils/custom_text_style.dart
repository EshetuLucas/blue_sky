import 'package:flutter/material.dart';

class CustomTextStyle {
  TextStyle textStyl(
      {double textSize, Color textColor, FontWeight textWeight}) {
    return TextStyle(
        letterSpacing: 1.4,
        color: textColor,
        fontWeight: textWeight,
        fontSize: textSize);
  }
}
