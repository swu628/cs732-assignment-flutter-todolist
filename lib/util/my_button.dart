import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  MyButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Text(text),
      color: Colors.yellow,
      // Use the shape property to define the border
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Border corner radius
      ),
    );
  }
}
