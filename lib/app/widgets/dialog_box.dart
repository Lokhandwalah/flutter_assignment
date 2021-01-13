import 'package:flutter/material.dart';
import '../utils/color_styles.dart';

class DialogBox extends StatelessWidget {
  final String title, content, btn1Text, btn2Text;
  final Color titleColor, contentColor, btn1Color, btn2Color;
  final Function btn1Func, btn2Func;
  const DialogBox(
      {Key key,
      @required this.title,
      this.content,
      this.btn1Text,
      this.btn2Text,
      this.btn1Func,
      this.btn2Func,
      this.titleColor,
      this.contentColor,
      this.btn1Color,
      this.btn2Color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Card(
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(
                    color: titleColor ?? primary,
                    fontSize: 35,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                content,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: contentColor ?? black,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: FlatButton(
                      onPressed: btn1Func,
                      splashColor: primary,
                      child: Text(
                        btn1Text,
                        style: TextStyle(
                          color: btn1Color ?? black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  if (btn2Text != null)
                    Expanded(
                      child: FlatButton(
                        onPressed: btn2Func,
                        splashColor: primary,
                        child: Text(
                          btn2Text,
                          style: TextStyle(
                            color: btn2Color ?? black,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
