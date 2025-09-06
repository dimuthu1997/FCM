import 'package:fcm/services/push_notification_service.dart.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/home_screen.dart';
import 'screens/products_screen.dart';
import 'screens/notification_screen.dart';
import 'screens/notification_detail_screen.dart';

final ValueNotifier<int> bottomNavIndex = ValueNotifier<int>(0);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await PushNotificationService.instance.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: bottomNavIndex,
      builder: (context, index, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            '/home': (_) => const HomeScreen(),
            '/products': (_) => const ProductsScreen(),
            '/notifications': (_) => const NotificationScreen(),
            '/notification-detail': (_) => const NotificationDetailScreen(),
          },
          home: MainScaffold(currentIndex: index),
        );
      },
    );
  }
}

class MainScaffold extends StatelessWidget {
  final int currentIndex;
  const MainScaffold({required this.currentIndex, super.key});

  static final tabs = [
    const HomeScreen(),
    const ProductsScreen(),
    const NotificationScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) => bottomNavIndex.value = i,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
        ],
      ),
    );
  }
}
