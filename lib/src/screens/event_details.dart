

import 'package:doubles/src/themes/colors.dart';
import 'package:doubles/src/widgets/bold_text.dart';
import 'package:doubles/src/widgets/button.dart';
import 'package:doubles/src/widgets/main_text.dart';
import 'package:flutter/material.dart';
import 'package:doubles/src/model/events.dart';
import 'package:intl/intl.dart';

import '../widgets/OvalIcon.dart';

class EventDetails extends StatefulWidget {
  const EventDetails({super.key});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    final Event event = ModalRoute.of(context)!.settings.arguments as Event;
    return  Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: OvalIcon(icon: Icons.notifications_outlined),
        ),
        actions: [
          const OvalIcon(icon: Icons.more_vert),
          const SizedBox(width: 10),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFC052DF),
              Color(0xFF23236C),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      // margin: const EdgeInsets.only(top: 10),
                      width: MediaQuery.of(context).size.width - 20,
                      height: 500,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.06),
                          borderRadius: const BorderRadius.all(Radius.circular(20))
                      ),
                      child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                        decoration: BoxDecoration(image: DecorationImage(image: NetworkImage("http://10.0.2.2:8080${event.eventImages}"), fit: BoxFit.cover), borderRadius: const BorderRadius.all(Radius.circular(20))),
                        )
                        ),
                    SizedBox(height: 20,),
                    BoldText(text: event.eventTitle, color: Colors.white, fontSize: 20,),
                    MainText(text: "Hosted by ${event.eventHost}"),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                
                      children: [
                        Container(
                          width: 35,
                
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 1.0
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(4))
                          ),
                          child: Column(
                            children: [
                              Container(
                        
                                child: Center(child: MainText(text: "Mar", fontSize: 10,)),
                                color: Colors.white.withOpacity(0.40),
                                width: 35,
                              ),
                              MainText(text: "27")
                            ],
                          ),
                        ),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MainText(text: DateFormat('EEEE d MMMM').format(event.eventStartDate), fontWeight: FontWeight.bold,),
                            MainText(text: "${event.eventStartTime} - ${event.eventEndTime} GMT", fontSize: 12,),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 35,
                          padding: EdgeInsets.symmetric(vertical: 2),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.white,
                                  width: 1.0
                              ),
                              borderRadius: const BorderRadius.all(Radius.circular(4))
                          ),
                          child: Icon(Icons.location_on, color: Colors.white, size: 20,)
                        ),
                        SizedBox(width: 10,),
                        Container(width: MediaQuery.of(context).size.width - 100, child: MainText(text: event.eventLocation, maxLines: 1,))
                      ],
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.08), borderRadius: const BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                
                          Container(
                
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(5)), color: Colors.white.withOpacity(0.30)),
                            child: MainText(text: "Registration",),
                          ),
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            width: MediaQuery.of(context).size.width - 150,
                              child: MainText(text: "Welcome! To join the event, please register below", maxLines: 2,)),
                          Center(child: Button(text: "Register", height: 40, width: MediaQuery.of(context).size.width - 100, color: Colors.purple,))
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    BoldText(text: "About Event", fontSize: 14, color: Colors.white,),
                    MainText(text: event.eventDescription, maxLines: 50,),
                
                    Divider(
                      
                    )
                  ],
                ),
              ),
            ),
          )
      )
    );
  }
}
