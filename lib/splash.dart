import 'package:camera_application/page_one.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    wait(context);
    return Scaffold(
      body: Center(
        child: Image.asset('assets/logo_gallery.png'),
      ),
    );
  }

  void wait(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => MyHomePage(),
    ));
  }
}
