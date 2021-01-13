import 'package:flutter/cupertino.dart';
import './screens/signup_screen.dart';

class AppNavigator {
  static Map<String, Widget Function(BuildContext)> routes = {
    SignupScreen.route: (context) => SignupScreen(),
  };
}
