import 'package:flutter/material.dart';
import '../models/notification_model.dart';

class NotificationController extends ChangeNotifier {
  static final NotificationController instance =
      NotificationController._internal();
  NotificationController._internal();

  final List<AppNotification> _notifications = [];

  List<AppNotification> get notifications => List.unmodifiable(_notifications);

  Future<void> loadNotifications() async {
    // No storage → just clear or keep existing
    _notifications.clear();
    notifyListeners();
  }

  Future<void> addNotification(AppNotification notification) async {
    _notifications.insert(0, notification);
    notifyListeners();
  }

  Future<void> clear() async {
    _notifications.clear();
    notifyListeners();
  }
}
