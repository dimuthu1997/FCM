import 'package:flutter/material.dart';
import '../controllers/notification_controller.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: AnimatedBuilder(
        animation: NotificationController.instance,
        builder: (context, _) {
          final notifications = NotificationController.instance.notifications;
          if (notifications.isEmpty) {
            return const Center(child: Text('No notifications yet'));
          }
          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final n = notifications[index];
              return ListTile(
                title: Text(n.title ?? 'No title'),
                subtitle: Text(n.body ?? 'No body'),
                trailing: Text(
                  '${n.receivedAt.hour}:${n.receivedAt.minute.toString().padLeft(2, '0')}',
                ),
                onTap: () {
                  // Navigate to notification details screen
                  Navigator.pushNamed(
                    context,
                    '/notification-detail',
                    arguments: n,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
