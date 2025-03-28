import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../service/events.dart';
import '../widgets/OvalIcon.dart';
import '../widgets/SessionCards.dart';
import '../widgets/main_text.dart';
import '../model/events.dart'; // Import the event model if you have one

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  int _selectedChipIndex = 0;
  final String name = "Andrews";
  final List<String> _chipLabels = ["Upcoming events", "Past events"];
  final EventService _eventService = EventService();
  late Future<List<Event>> _futureEvents;

  @override
  void initState() {
    super.initState();
    _futureEvents = _eventService.getAllEvents();
  }

  @override
  Widget build(BuildContext context) {
    final List<dynamic> jsonData = ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    // print(jsonData);
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
              Color(0xFFC052DF),
              Color(0xFF23236C),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  _futureEvents = _eventService.getAllEvents();
                });
                await _futureEvents;
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MainText(text: "Good day! $name"),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(100)),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          fillColor: Colors.red,
                          border: InputBorder.none,
                          hintText: "find events in...",
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(_chipLabels.length, (index) {
                            return Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedChipIndex = index;
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  width: 150,
                                  height: 34,
                                  decoration: BoxDecoration(
                                      color: index == _selectedChipIndex
                                          ? Colors.white
                                          : Colors.white.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Center(
                                    child: MainText(
                                      text: _chipLabels[index],
                                      color: index == _selectedChipIndex
                                          ? Colors.purple
                                          : Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    MainText(
                        text: "Upcoming Events",
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    FutureBuilder<List<Event>>(
                      future: _futureEvents,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(child: Text('No events found'));
                        } else {
                          final events = snapshot.data!;
                          return Column(
                            children: events.map((event) {
                              return SessionCard(
                                image: "http://10.0.2.2:8080${event.eventImages}",
                                sessionTitle: event.eventTitle,
                                startTime: event.eventStartTime,
                                location: event.eventLocation,
                                onTap: (){
                                  Navigator.pushNamed(context, "/events-details", arguments: event);

                                },
                              );
                            }).toList(),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}