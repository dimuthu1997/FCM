import 'package:flutter/material.dart';
import '../models/notification_model.dart';
import '../services/notification_storage_service.dart';

class NotificationController extends ChangeNotifier {
  static final NotificationController instance =
      NotificationController._internal();
  NotificationController._internal() {
    loadNotifications();
  }

  final List<AppNotification> _notifications = [];

  List<AppNotification> get notifications => List.unmodifiable(_notifications);

  Future<void> loadNotifications() async {
    _notifications.clear();
    _notifications.addAll(
      await NotificationStorageService().getNotifications(),
    );
    notifyListeners();
  }

  Future<void> addNotification(AppNotification notification) async {
    _notifications.insert(0, notification);
    await NotificationStorageService().saveNotification(notification);
    notifyListeners();
  }

  Future<void> clear() async {
    _notifications.clear();
    await NotificationStorageService().clearNotifications();
    notifyListeners();
  }
}
