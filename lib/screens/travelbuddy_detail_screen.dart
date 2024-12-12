import 'package:flutter/material.dart';

class TravelBuddyDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final buddy = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(buddy['name'] ?? 'Buddy Details'),
        backgroundColor: const Color(0xFF4169E1), // Royal Blue
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display buddy's image if available
            if (buddy.containsKey('image') && buddy['image'] != null)
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(buddy['image']),
                ),
              ),
            const SizedBox(height: 20),
            // Display buddy's name
            Text(
              buddy['name'] ?? 'Name not available',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Display email if available
            if (buddy.containsKey('email'))
              Text(
                'Email: ${buddy['email']}',
                style: const TextStyle(fontSize: 16),
              ),
            const SizedBox(height: 10),
            // Display location if available
            if (buddy.containsKey('location'))
              Text(
                'Location: ${buddy['location']}',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            const SizedBox(height: 10),
            // Display expertise if available
            if (buddy.containsKey('expertise'))
              Text(
                'Expertise: ${buddy['expertise']}',
                style: const TextStyle(fontSize: 16),
              ),
            const Spacer(),
            // Request buddy button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    '/travelbuddy-request',
                    arguments: buddy,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4169E1), // Royal Blue
                ),
                child: const Text('Request This Buddy'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
