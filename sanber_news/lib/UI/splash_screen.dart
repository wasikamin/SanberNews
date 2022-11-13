import 'package:flutter/material.dart';
import 'package:sanber_news/UI/login_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset("assets/icons/sanbernews_logo.png"),
      backgroundColor: Color.fromARGB(255, 71, 91, 216),
      splashTransition: SplashTransition.fadeTransition,
      nextScreen: LoginScreen(),
      duration: 2500,
      pageTransitionType: PageTransitionType.leftToRightWithFade,
    );
  }
}
