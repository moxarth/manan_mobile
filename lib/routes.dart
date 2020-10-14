import 'package:flutter/material.dart';
import 'package:manan_mobile/landing_page.dart';
import 'package:manan_mobile/screens/home_page.dart';
import 'package:manan_mobile/screens/login_page.dart';
import 'package:manan_mobile/screens/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  LandingPage.routeName: (context) => LandingPage(),
  HomePage.routeName: (context) => HomePage(),
  LoginPage.routeName: (context) => LoginPage(),
};