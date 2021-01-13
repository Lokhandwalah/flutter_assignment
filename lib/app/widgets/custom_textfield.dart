import 'package:flutter/material.dart';
import '../utils/color_styles.dart';

class MyTextField extends StatelessWidget {
  final Widget child;

  const MyTextField({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Card(
        elevation: 10,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8), child: child),
      ),
    );
  }

  static InputDecoration textFieldDecoration(
      {IconData prefixIcon,
      Color iconColor,
      String label,
      String hint,
      TextStyle labelStyle,
      TextStyle hintStyle}) {
    return InputDecoration(
      prefixIcon: prefixIcon != null
          ? Icon(
              prefixIcon,
              color: iconColor ?? primary,
            )
          : null,
      labelText: label,
      labelStyle: labelStyle ?? TextStyle(color: primary),
      hintText: hint,
      hintStyle: hintStyle,
    );
  }
}
