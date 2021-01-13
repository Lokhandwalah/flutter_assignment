import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String title;
  final Color titleColor, btnColor, splashColor;
  final Function action;
  const MyButton(
      {Key key,
      this.action,
      this.title,
      this.titleColor,
      this.btnColor,
      this.splashColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        width: MediaQuery.of(context).size.width * 0.75,
        child: RaisedButton(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              title,
              style: TextStyle(color: titleColor, fontSize: 20),
            ),
          ),
          onPressed: action,
          color: btnColor,
        ),
      ),
    );
  }
}
