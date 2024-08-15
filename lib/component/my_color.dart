import 'package:flutter/material.dart';

class SolidColors {
  static const Color surface = Color(0xFF1E1E1E);
  static const Color iconColor = Color(0x50FFFFFF);
  static const Color accent = Color(0xFFFFA500);
  static const Color disabledBackgroundColor = Colors.black12;
  static const Color disabledForegroundColor = Colors.white12;

  static const TextStyle inputStyle =
      TextStyle(color: Colors.white, fontSize: 20);
  static const TextStyle hintStyle = TextStyle(color: iconColor);
  static const TextStyle counterStyle =
      TextStyle(color: iconColor, fontSize: 14);
  static const TextStyle splashStyke = TextStyle(
      color: accent,
      fontSize: 60,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w500);
}
