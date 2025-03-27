
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ExpandedText.dart';
import 'main_text.dart';


class SessionCard extends StatelessWidget {
  final String image;
  final String sessionTitle;
  final String startTime;
  final String location;
  final onTap;
  const SessionCard({super.key, required this.image, required this.sessionTitle, required this.startTime, required this.location, this.onTap});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      child: Container(
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
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)),
            ),
            const SizedBox(height: 10,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(

                  width: MediaQuery.of(context).size.width *0.7,
                    child: MainText(text: sessionTitle, fontSize: 20, maxLines: 2,)),
                MainText(text: startTime, color: Colors.green,)
              ],
            ),
            const SizedBox(height: 5,),
            Row(
              children: [
                Icon(Icons.location_pin, color: Colors.white,),
                Container(
                    width: MediaQuery.of(context).size.width *0.7,
                    child: MainText(text: location, maxLines: 1,)),
              ],
            )
          ],

        ),
      ),
    );
  }
}
