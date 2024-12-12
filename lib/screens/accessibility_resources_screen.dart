import 'package:flutter/material.dart';

class AccessibilityResourcesScreen extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {'title': 'Wheelchair-Friendly Hotels', 'icon': 'hotel'},
    {'title': 'Accessible Transportation', 'icon': 'directions_bus'},
    {'title': 'Guides for the Blind', 'icon': 'visibility'},
    {'title': 'Assistive Devices', 'icon': 'build'},
    {'title': 'Accessible Tourist Attractions', 'icon': 'attractions'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accessibility Resources'),
        backgroundColor: const Color(0xFF4169E1), // Royal Blue
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Icon(
                getApplicableIcon(category['icon']!), // Use the standalone method
                color: const Color(0xFF4169E1),
              ),
              title: Text(category['title']!),
              trailing: const Icon(Icons.arrow_forward, color: Color(0xFF4169E1)),
              onTap: () {
                Navigator.of(context).pushNamed(
                  '/resource-list',
                  arguments: category,
                );
              },
            ),
          );
        },
      ),
    );
  }

  // Standalone utility method to get applicable icons
  IconData getApplicableIcon(String icon) {
    switch (icon) {
      case 'hotel':
        return Icons.hotel;
      case 'directions_bus':
        return Icons.directions_bus;
      case 'visibility':
        return Icons.visibility;
      case 'build':
        return Icons.build;
      case 'attractions':
        return Icons.attractions;
      default:
        return Icons.info;
    }
  }
}
