import 'dart:convert';
import 'package:doubles/src/model/events.dart';
import 'package:http/http.dart' as http;

class EventService {
  final String baseUrl = 'https://doublesapi.vercel.app/api/v1/event/get-events';

  Future<List<Event>> getAllEvents() async {
    final response = await http.get(Uri.parse(baseUrl));
    print(response.body);

    if (response.statusCode == 201) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      print(responseBody);

      // Extract 'data' key if the response is wrapped in status/message/data
      final List<dynamic> eventsJson = responseBody['data'];

      return eventsJson.map((json) => Event.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load events');
    }
  }
}
