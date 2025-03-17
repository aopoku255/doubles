
import 'package:flutter/material.dart';

import 'main_text.dart';

class Button extends StatelessWidget {
  final String text;
  final Color? color;
  final double radius;
  final double horizontal;
  final double vertical;
  final double fontSize;
  final bool? withIcon;
  final String? iconImage;
  final onTap;
  const Button({
    super.key,
    required this.text,
    this.color = Colors.blue,
    this.onTap,
    this.radius = 12.0,
    this.horizontal = 50,
    this.vertical = 15,
    this.fontSize = 14, this.withIcon = false, this.iconImage = "assets/images/google.png",
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
       width: MediaQuery.of(context).size.width,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: color,
        ),
        child: withIcon! ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(iconImage!, height: 30,),
            SizedBox(width: 20,),
            MainText(text: text, color: Colors.black,)
          ],
        ) : Center(
          child: MainText(
            text: text,
            textAlign: TextAlign.center,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
