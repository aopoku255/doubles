import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/OvalIcon.dart';
import '../widgets/SessionCards.dart';
import '../widgets/main_text.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  int _selectedChipIndex = 0; // Track selected chip index
  final String name = "Andrews";
  final String title = "";
  final List<String> _chipLabels = ["Music", "Food", "Sports", "Movies"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFC052DF), // First color
              Color(0xFF23236C), // Second color
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MainText(text: "Good day! ${name}"),
                  const SizedBox(height: 20),
                  MainText(text: title),

                  // Chips Row
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(_chipLabels.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedChipIndex = index; // Update selected index
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 20),
                                width: 120,
                                height: 34,
                                decoration: BoxDecoration(color: index == _selectedChipIndex ? Colors.white : Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(50)),
                                child: Center(child: MainText(text:_chipLabels[index], color: index == _selectedChipIndex ? Colors.purple : Colors.white, fontWeight: FontWeight.bold,)),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  _selectedChipIndex >= 1 ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MainText(text: "Keynote Speakers", fontWeight: FontWeight.bold, fontSize: 16,),

                      SessionCard(image: "assets/images/music.jpg", sessionTitle: "Dale Rogers", startTime: "", description: "Dale S. Rogers is the ON Semiconductor Professor of Business at the Supply Chain Management department at Arizona State University. He is also the director of the Frontier Economies Logistics Lab and the co-director of the Internet Edge Supply Chain Lab at ASU."),
                      SessionCard(image: "assets/images/music.jpg", sessionTitle: "Thomas Choi", startTime: "", description: "Thomas Choi is a Professor of Supply Chain Management at the W. P. Carey School of Business at Arizona State University. He leads the study of the upstream side of supply chains, where a buying company interfaces with many suppliers organized in various forms of networks.")
                    ],
                  ) : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const MainText(text: "Upcoming events", fontWeight: FontWeight.bold, fontSize: 16),
                      SessionCard(
                        image: "assets/images/music.jpg",
                        sessionTitle: "Registration",
                        startTime: "8:30am",
                        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                      ),
                      const SizedBox(height: 40),
                      MainText(text: "past events", fontWeight: FontWeight.bold, fontSize: 16),
                      SessionCard(
                        image: "assets/images/music.jpg",
                        sessionTitle: "Panel Discussion",
                        startTime: "10:30am",
                        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                      ),
                      SessionCard(
                        image: "assets/images/music.jpg",
                        sessionTitle: "Cultural Dance",
                        startTime: "12:30pm",
                        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  }

