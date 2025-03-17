
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ExpandedText.dart';
import 'main_text.dart';


class SessionCard extends StatelessWidget {
  final String image;
  final String sessionTitle;
  final String startTime;
  final String description;
  const SessionCard({super.key, required this.image, required this.sessionTitle, required this.startTime, required this.description});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 20),
      width: MediaQuery.of(context).size.width,
      height: 350,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.06),
          borderRadius: const BorderRadius.all(Radius.circular(20))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MainText(text: sessionTitle, fontSize: 20,),
              MainText(text: startTime, color: Colors.green,)
            ],
          ),
          const SizedBox(height: 10,),
          ExpandableText(text: description)
        ],
      ),
    );
  }
}
