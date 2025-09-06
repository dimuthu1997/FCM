import 'package:shared_preferences/shared_preferences.dart';
import '../models/notification_model.dart';

class NotificationStorageService {
  static const String _key = 'notifications';

  Future<void> saveNotification(AppNotification notification) async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList(_key) ?? <String>[];
    stored.insert(0, notification.toJson());
    await prefs.setStringList(_key, stored);
  }

  Future<List<AppNotification>> getNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList(_key) ?? <String>[];
    return stored.map((s) => AppNotification.fromJson(s)).toList();
  }

  Future<void> clearNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
