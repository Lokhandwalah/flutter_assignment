import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'signup_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1),);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
    initialize();
  }

  void initialize() {
    Firebase.initializeApp().then(
      (_) => Future.delayed(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacementNamed(SignupScreen.route),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            FadeTransition(
              opacity: _animation,
              child: Container(
                height: 150,
                child: Image.asset(
                  'assets/images/app_icon.png',
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              child: CircularProgressIndicator(),
            )
          ],
        ),
      ),
    );
  }
}
