import 'dart:convert';

class AppNotification {
  final String? title;
  final String? body;
  final Map<String, dynamic>? data;
  final DateTime receivedAt;

  AppNotification({this.title, this.body, this.data})
    : receivedAt = DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'data': data,
      'receivedAt': receivedAt.toIso8601String(),
    };
  }

  factory AppNotification.fromMap(Map<String, dynamic> map) {
    return AppNotification(
      title: map['title'],
      body: map['body'],
      data: Map<String, dynamic>.from(map['data'] ?? {}),
    );
  }

  String toJson() => json.encode(toMap());
  factory AppNotification.fromJson(String source) =>
      AppNotification.fromMap(json.decode(source));
}
