import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../ui/auth_screen/login_screen.dart';
import '../ui/bottom_nav_controller.dart';

class SplashServices {
  void Login(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      Timer.periodic(Duration(seconds: 5), (timer) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => BottomNavController()),
            (route) => false);
      });
    } else {
      Timer.periodic(Duration(seconds: 5), (timer) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false);
      });
    }
  }
}
