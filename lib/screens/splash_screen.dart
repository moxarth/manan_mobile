import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:manan_mobile/landing_page.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = '/splash';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 3000),
      Navigator.pushNamed(context, LandingPage.routeName);
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width - 20.0,
          height: MediaQuery.of(context).size.height - 20.0,
          child: Lottie.asset("assets/animations/splash_anim.json"),
        ),
      ),
    );
  }
}
