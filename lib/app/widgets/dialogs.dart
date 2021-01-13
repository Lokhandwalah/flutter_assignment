import 'package:flutter/material.dart';
import '../utils/color_styles.dart';
import 'dialog_box.dart';

void showLoader(BuildContext context, {bool canPop = false}) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () => Future.value(canPop),
        child: loader,
      ),
    );

Future<bool> showConfirmationDialog(context,
        {String title, String content}) async =>
    await showDialog<bool>(
      context: context,
      builder: (_) => WillPopScope(
        onWillPop: () {
          Navigator.of(context).pop(false);
          return Future.value(true);
        },
        child: DialogBox(
          title: title,
          content: content,
          btn1Text: 'No',
          btn2Text: 'Yes',
          btn1Func: () => Navigator.of(context).pop(false),
          btn2Func: () => Navigator.of(context).pop(true),
          btn2Color: primary,
        ),
      ),
    );

Widget get loader => Center(child: CircularProgressIndicator());
