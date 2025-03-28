class Event {
  final String id;
  final String eventTitle;
  final String eventCategory;
  final String eventDescription;
  final String eventLocation;
  final DateTime eventStartDate;
  final DateTime eventEndDate;
  final String eventStartTime;
  final String eventEndTime;
  final String eventImages;
  final String eventHost;

  Event({
    required this.id,
    required this.eventTitle,
    required this.eventCategory,
    required this.eventDescription,
    required this.eventLocation,
    required this.eventStartDate,
    required this.eventEndDate,
    required this.eventStartTime,
    required this.eventEndTime,
    required this.eventImages,
    required this.eventHost,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['_id'],
      eventTitle: json['eventTitle'],
      eventCategory: json['eventCategory'],
      eventDescription: json['eventDescription'],
      eventLocation: json['eventLocation'],
      eventStartDate: DateTime.parse(json['eventStartDate']),
      eventEndDate: DateTime.parse(json['eventEndDate']),
      eventImages: json['eventImages'],
      eventStartTime: json['eventStartTime'],
      eventEndTime: json['eventEndTime'],
      eventHost: json['eventHost'],
    );
  }
}
