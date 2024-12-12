import 'package:flutter/material.dart';

class ResourceListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)?.settings.arguments as Map<String, String>;

    final List<Map<String, String>> resources = [
      if (category['title'] == 'Wheelchair-Friendly Hotels') ...[
        {'name': 'Hotel ABC', 'description': 'A wheelchair-friendly hotel in Delhi.', 'link': 'https://hotelabc.com'},
        {'name': 'Hotel XYZ', 'description': 'Fully accessible rooms in Mumbai.', 'link': 'https://hotelxyz.com'},
      ],
      if (category['title'] == 'Accessible Transportation') ...[
        {'name': 'City Bus Service', 'description': 'Buses with wheelchair ramps in Bangalore.', 'link': 'https://citybusservice.com'},
        {'name': 'Accessible Cabs', 'description': 'Cabs with wheelchair access in Hyderabad.', 'link': 'https://accessiblecabs.com'},
      ],
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(category['title']!),
        backgroundColor: const Color(0xFF4169E1), // Royal Blue
      ),
      body: ListView.builder(
        itemCount: resources.length,
        itemBuilder: (context, index) {
          final resource = resources[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(resource['name']!),
              subtitle: Text(resource['description']!),
              trailing: const Icon(Icons.arrow_forward, color: Color(0xFF4169E1)),
              onTap: () {
                Navigator.of(context).pushNamed(
                  '/resource-detail',
                  arguments: resource,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
