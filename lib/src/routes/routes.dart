
import 'package:doubles/src/screens/login.dart';
import 'package:doubles/src/screens/onboarding_screen.dart';
import 'package:doubles/src/screens/signup.dart';
import 'package:doubles/src/screens/singin.dart';
import 'package:flutter/cupertino.dart';

import '../screens/home.dart';

Map<String, WidgetBuilder> get appRoutes{
  return {
    '/': (context) => const OnboardingScreen(),
    '/onboarding': (context) => const OnboardingScreen(),
    '/login': (context) => const Login(),
    '/signin': (context) => const Signin(),
    '/signup': (context) => const Signup(),

  };
  }