import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_app_pc/component/my_color.dart';
import 'package:note_app_pc/component/my_snackbar.dart';

class MyTextfield extends StatefulWidget {
  final int maxLength;
  final int? maxLines;
  final String hintText;
  final TextEditingController controller;
  const MyTextfield({
    super.key,
    required this.maxLength,
    this.maxLines,
    required this.hintText,
    required this.controller,
  });

  @override
  State<MyTextfield> createState() => _MyTextfieldState();
}

class _MyTextfieldState extends State<MyTextfield> {
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void copyToCilpboard(context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    MySnackbar.showSnackBar(context, Icons.content_copy_rounded, 'Copied Message');
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focusNode,
      onEditingComplete: () => FocusScope.of(context).nextFocus,
      controller: widget.controller,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      keyboardType: TextInputType.multiline,
      cursorColor: SolidColors.accent,
      style: SolidColors.inputStyle,
      decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: SolidColors.hintStyle,
          suffixIcon: _copyButton(context),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: SolidColors.accent,
          )),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: SolidColors.iconColor),
          ),
          counterStyle: SolidColors.counterStyle),
    );
  }

  IconButton _copyButton(BuildContext context) {
    return IconButton(
        onPressed: widget.controller.text.isNotEmpty
            ? () => copyToCilpboard(context, widget.controller.text)
            : null,
        splashRadius: 20,
        splashColor: SolidColors.accent,
        color: SolidColors.accent,
        disabledColor: SolidColors.iconColor,
        icon: const Icon(Icons.content_copy_rounded));
  }
}
