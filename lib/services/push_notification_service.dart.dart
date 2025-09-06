import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../controllers/notification_controller.dart';
import '../main.dart';
import '../models/notification_model.dart';

class PushNotificationService {
  static final PushNotificationService instance =
      PushNotificationService._internal();
  PushNotificationService._internal();

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  Future<void> initialize() async {
    await _fcm.requestPermission(alert: true, badge: true, sound: true);

    final token = await _fcm.getToken();
    print('✅ FCM Token: $token');

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const initSettings = InitializationSettings(android: androidSettings);

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
        final page = details.payload ?? 'notifications';
        _navigateToPage(page);
      },
    );

    if (!Platform.isIOS) {
      await _localNotifications
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(channel);
    }

    FirebaseMessaging.onMessage.listen(_handleMessage);
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) _handleMessage(message, navigate: true);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _handleMessage(message, navigate: true);
    });
  }

  void _handleMessage(RemoteMessage message, {bool navigate = false}) {
    final notification = message.notification;
    final android = message.notification?.android;

    if (notification != null && android != null) {
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            importance: Importance.high,
            priority: Priority.high,
          ),
        ),
        payload: message.data['page'] ?? 'notifications',
      );
    }

    final appNotification = AppNotification(
      title: notification?.title,
      body: notification?.body,
      data: message.data,
    );

    NotificationController.instance.addNotification(appNotification);

    if (navigate) {
      _navigateToPage(message.data['page'] ?? 'notifications');
    }
  }

  void _navigateToPage(String page) {
    switch (page) {
      case 'home':
        bottomNavIndex.value = 0;
        break;
      case 'products':
        bottomNavIndex.value = 1;
        break;
      case 'notifications':
      default:
        bottomNavIndex.value = 2;
        break;
    }
  }
}
