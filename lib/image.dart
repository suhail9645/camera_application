import 'dart:io';


import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  const ImageView({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 31, 31, 32),
       body: Center(
        child: Image(image: FileImage(File(image),),),
       ),
    );
  }
}