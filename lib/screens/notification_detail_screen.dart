import 'package:flutter/material.dart';
import '../models/notification_model.dart';

class NotificationDetailScreen extends StatelessWidget {
  const NotificationDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppNotification n =
        ModalRoute.of(context)!.settings.arguments as AppNotification;

    return Scaffold(
      appBar: AppBar(title: const Text('Notification Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              n.title ?? 'No title',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(n.body ?? 'No body', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 12),
            if (n.data != null)
              Text(
                'Data: ${n.data}',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }
}
