import 'package:flutter/material.dart';
import 'package:note_app_pc/component/my_color.dart';

class MySnackbar {
  static void showSnackBar(
      BuildContext context, IconData icon, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
      children: [
        Icon(
          icon,
          color: SolidColors.accent,
        ),
        const SizedBox(
          width: 6,
        ),
        Text(message)
      ],
    )));
  }
}
