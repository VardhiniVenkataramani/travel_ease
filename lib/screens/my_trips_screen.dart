import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyTripsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Trips'),
        backgroundColor: const Color(0xFF4169E1), // Royal Blue
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('myTrips').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No trips booked yet.',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          final trips = snapshot.data!.docs;

          return ListView.builder(
            itemCount: trips.length,
            itemBuilder: (context, index) {
              final trip = trips[index];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: const Icon(Icons.location_on, color: Color(0xFF4169E1)),
                  title: Text(
                    trip['packageName'] ?? 'Unknown Package',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Location: ${trip['location']}\nDate: ${trip['date']?.toDate().toString().split(' ')[0]}',
                  ),
                  trailing: Text(
                    trip['price'] ?? 'N/A',
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
