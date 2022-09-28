import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  const MyText({
    Key? key,
    required this.myTitle,
    required this.textSize,
    required this.textColor,
  }) : super(key: key);

  final String myTitle;
  final double textSize;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        myTitle,
        style: TextStyle(
          fontSize: textSize,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }
}
