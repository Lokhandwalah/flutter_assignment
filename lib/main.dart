import 'package:flutter/material.dart';
import 'app/screens/splash_screen.dart';
import 'app/navigator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: SplashScreen(),
      routes: AppNavigator.routes,
    );
  }
}
