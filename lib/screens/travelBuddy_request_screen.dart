import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TravelBuddyRequestScreen extends StatelessWidget {
  final Map<String, dynamic> buddyDetails;

  const TravelBuddyRequestScreen({Key? key, required this.buddyDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController messageController = TextEditingController();

    Future<void> sendRequest() async {
      try {
        // Save request to Firestore
        await FirebaseFirestore.instance.collection('buddyRequests').add({
          'buddyId': buddyDetails['id'],
          'buddyName': buddyDetails['name'],
          'message': messageController.text,
          'timestamp': Timestamp.now(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Request sent successfully!')),
        );

        Navigator.of(context).pop();
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to send request. Please try again.')),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Travel Buddy'),
        backgroundColor: const Color(0xFF4169E1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Requesting: ${buddyDetails['name']}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: messageController,
              decoration: const InputDecoration(
                labelText: 'Your Message',
                hintText: 'Why do you want to request this buddy?',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: sendRequest,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4169E1),
                ),
                child: const Text('Send Request'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
