import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:travel_ease/screens/edit_profile_screen.dart';
import 'package:travel_ease/screens/home_screen.dart';
import 'package:travel_ease/screens/login_screen.dart';
import 'package:travel_ease/screens/notification_preferences_screen.dart';
import 'package:travel_ease/screens/notifications_screen.dart';
import 'package:travel_ease/screens/profile_screen.dart';
import 'package:travel_ease/screens/resources_list.dart';
import 'package:travel_ease/screens/signup_screen.dart';
import 'package:travel_ease/screens/travelease_chat_screen.dart';
import 'package:travel_ease/screens/travel_categories_screen.dart';
import 'package:travel_ease/screens/packages_screen.dart';
import 'package:travel_ease/screens/package_detail_screen.dart';
import 'package:travel_ease/screens/booking_screen.dart';
import 'package:travel_ease/screens/my_trips_screen.dart';
import 'package:travel_ease/screens/travelbuddy_finder_screen.dart';
import 'package:travel_ease/screens/travelBuddy_request_screen.dart'; // Ensure correct class is imported
import 'package:travel_ease/screens/travelbuddy_detail_screen.dart';
import 'package:travel_ease/screens/accessibility_resources_screen.dart';
import 'package:travel_ease/screens/resource_detail_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Request permissions for iOS
  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    sound: true,
  );

  runApp(const TravelEaseApp());
}

class TravelEaseApp extends StatelessWidget {
  const TravelEaseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TravelEase',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login', // Set the default route
      routes: {
        // Authentication Routes
        '/login': (ctx) => LoginScreen(),
        '/signup': (ctx) => SignupScreen(),

        // Home and Main Features
        '/home': (ctx) => HomeScreen(),
        '/travelbuddy-finder': (ctx) => TravelBuddyFinderScreen(),
        '/my-trips': (ctx) => MyTripsScreen(),
        '/resources': (ctx) => AccessibilityResourcesScreen(),
        '/chat': (ctx) => WitAiChatScreen(),

        // Travel Categories and Packages
        '/categories': (ctx) => TravelCategoriesScreen(),
        '/packages': (ctx) => PackagesScreen(),
        '/package-detail': (ctx) => PackageDetailScreen(),

        // Accessibility Resources
        '/accessibility-resources': (ctx) => AccessibilityResourcesScreen(),
        '/resource-list': (ctx) => ResourceListScreen(),
        '/resource-detail': (ctx) => ResourceDetailScreen(),

        // Booking
        '/booking': (ctx) => BookingScreen(package: {}),

        // Notifications and Profile
        '/notifications': (ctx) => NotificationScreen(),
        '/notification-preferences': (ctx) => NotificationPreferencesScreen(),
        '/profile': (ctx) => ProfileScreen(),
        '/edit-profile': (ctx) => EditProfileScreen(),

        // Travel Buddy Screens
        '/travelbuddy-detail': (ctx) => TravelBuddyDetailScreen(),


      },
    );
  }
}
