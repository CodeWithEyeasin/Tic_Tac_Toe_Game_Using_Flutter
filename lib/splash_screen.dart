import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tic_tac_toe_game/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 4));
    Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF323D5B),
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            Container(
              height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle
                ),
                child: Image.asset('assets/logo.png',)),
            const Text('Kata Kati Game',style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.white
            ),),
            const SizedBox(height: 16,),
            Column(
              children: [
                Center(
                  child: LoadingAnimationWidget.twistingDots(
                      leftDotColor: const Color(0xFFE25041),
                      rightDotColor: const Color(0xFF1CBD9E),
                      size: 55),
                )
              ],
            ),
            const Spacer(),

          ],
        ),
      ),
    );
  }
}
