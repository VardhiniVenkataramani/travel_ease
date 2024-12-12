import 'package:flutter/material.dart';

class NotificationPreferencesScreen extends StatefulWidget {
  @override
  _NotificationPreferencesScreenState createState() => _NotificationPreferencesScreenState();
}

class _NotificationPreferencesScreenState extends State<NotificationPreferencesScreen> {
  bool _bookingNotifications = true;
  bool _buddyNotifications = true;
  bool _generalNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Preferences'),
        backgroundColor: const Color(0xFF4169E1), // Royal Blue
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SwitchListTile(
            title: const Text('Booking Notifications'),
            value: _bookingNotifications,
            onChanged: (value) {
              setState(() {
                _bookingNotifications = value;
              });
            },
          ),
          const Divider(),
          SwitchListTile(
            title: const Text('Buddy Notifications'),
            value: _buddyNotifications,
            onChanged: (value) {
              setState(() {
                _buddyNotifications = value;
              });
            },
          ),
          const Divider(),
          SwitchListTile(
            title: const Text('General Updates'),
            value: _generalNotifications,
            onChanged: (value) {
              setState(() {
                _generalNotifications = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
