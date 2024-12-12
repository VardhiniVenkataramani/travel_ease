import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourceDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final resource = ModalRoute.of(context)?.settings.arguments as Map<String, String>;

    return Scaffold(
      appBar: AppBar(
        title: Text(resource['name']!),
        backgroundColor: const Color(0xFF4169E1), // Royal Blue
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              resource['name']!,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(resource['description']!, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final url = resource['link'];
                if (await canLaunch(url!)) {
                  await launch(url);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Could not open the link.')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4169E1), // Royal Blue
              ),
              child: const Text('Visit Website'),
            ),
          ],
        ),
      ),
    );
  }
}
