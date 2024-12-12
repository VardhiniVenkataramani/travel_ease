import 'package:flutter/material.dart';

class TravelCategoriesScreen extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {'name': 'Scheduled Group Tours', 'icon': 'group'},
    {'name': 'Local City Tours', 'icon': 'location_city'},
    {'name': 'Customized Tours', 'icon': 'settings'},
    {'name': 'Romantic Tours', 'icon': 'favorite'},
    {'name': 'Spiritual Travel', 'icon': 'spa'},
    {'name': 'Adventure Tours', 'icon': 'terrain'},
    {'name': 'Family Trips', 'icon': 'family_restroom'},
    {'name': 'Solo Travel', 'icon': 'person'},
  ];

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'group':
        return Icons.group;
      case 'location_city':
        return Icons.location_city;
      case 'settings':
        return Icons.settings;
      case 'favorite':
        return Icons.favorite;
      case 'spa':
        return Icons.spa;
      case 'terrain':
        return Icons.terrain;
      case 'family_restroom':
        return Icons.family_restroom;
      case 'person':
        return Icons.person;
      default:
        return Icons.help_outline; // Fallback icon
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accessible Travel Packages'),
        backgroundColor: const Color(0xFF4169E1), // Royal Blue
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                '/packages',
                arguments: category['name'],
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF4169E1),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _getIcon(category['icon']!), // Dynamically get the icon
                    color: Colors.white,
                    size: 40,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    category['name']!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
