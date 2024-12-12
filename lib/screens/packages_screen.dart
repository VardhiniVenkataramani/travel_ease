import 'package:flutter/material.dart';

class PackagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)?.settings.arguments as String;

    // Merged list of travel packages
    final packages = [
      {
        'name': 'Taj Mahal Tour',
        'location': 'Agra, Uttar Pradesh',
        'image': 'https://upload.wikimedia.org/wikipedia/commons/d/da/Taj-Mahal.jpg',
        'price': '₹12,000',
        'accessible': true,
      },
      {
        'name': 'Backwaters of Kerala',
        'location': 'Alleppey, Kerala',
        'image': 'https://th.bing.com/th/id/OIP.Ylq--wlSqUTbxr5uSF_ecQHaFj?rs=1&pid=ImgDetMain',
        'price': '₹15,000',
        'accessible': true,
      },
      {
        'name': 'Explore Jaipur',
        'location': 'Jaipur, Rajasthan',
        'image': 'https://th.bing.com/th/id/OIP.KQ0tpdd2dkXxXo_-VqQORQHaEc?rs=1&pid=ImgDetMain', // Placeholder
        'price': '₹10,000',
        'accessible': true,
      },
      {
        'name': 'Golden Temple Tour',
        'location': 'Amritsar, Punjab',
        'image': 'https://th.bing.com/th/id/OSK.HERO7sdOY3F2UF9Pk72sXUqOXiI4fMjS_A3rG5xoZcvc6EU?rs=1&pid=ImgDetMain',
        'price': '₹10,000',
        'accessible': true,
      },
      {
        'name': 'Rajasthan Heritage Tour',
        'location': 'Jaipur, Rajasthan',
        'image': 'https://th.bing.com/th/id/OIP.n0nld0bQWsjvpqNf8m9ZMwHaFp?rs=1&pid=ImgDetMain',
        'price': '₹18,000',
        'accessible': true,
      },
      {
        'name': 'Goa Beach Escape',
        'location': 'Goa',
        'image': 'https://th.bing.com/th/id/OIP.4TQVKBd2XNTCScPADYbxcQHaEK?rs=1&pid=ImgDetMain',
        'price': '₹20,000',
        'accessible': true,
      },
      {
        'name': 'Kashmir Paradise Tour',
        'location': 'Srinagar, Jammu & Kashmir',
        'image': 'https://img.veenaworld.com/wp-content/uploads/2023/01/shutterstock_2044050407-scaled.jpg',
        'price': '₹25,000',
        'accessible': true,
      },
      {
        'name': 'Meghalaya Nature Trail',
        'location': 'Shillong, Meghalaya',
        'image': 'https://4.bp.blogspot.com/-Y8uPNPAIPBg/WNi-kCcR0FI/AAAAAAAAvyo/n-c5bF5TBmk8QIHcnVVVuJ8U6CD_c-yCgCLcB/s1600/Nohkalikai.jpg',
        'price': '₹22,000',
        'accessible': true,
      },
      {
        'name': 'Statue of Unity Tour',
        'location': 'Gujarat',
        'image': 'https://img.nayatrip.com/images/state/big/GUJARAT.jpg',
        'price': '₹12,500',
        'accessible': true,
      },
      {
        'name': 'Andaman Islands Getaway',
        'location': 'Port Blair, Andaman',
        'image': 'https://th.bing.com/th/id/OIP.jjK7Ah_eSEhDQ5tgK3zI9wHaEo?rs=1&pid=ImgDetMain',
        'price': '₹30,000',
        'accessible': true,
      },
      {
        'name': 'Leh Ladakh Adventure',
        'location': 'Leh, Ladakh',
        'image': 'https://static.toiimg.com/photo/64764925/leh-mountains.jpg?width=748&resize=4',
        'price': '₹28,000',
        'accessible': false,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        backgroundColor: const Color(0xFF4169E1), // Royal Blue
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Placeholder for filter action
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Filter functionality coming soon!')),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: packages.length,
        itemBuilder: (context, index) {
          final package = packages[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                '/package-detail',
                arguments: package,
              );
            },
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                leading: Image.network(
                  package['image'].toString(),
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image, size: 50);
                  },
                ),
                title: Text(package['name'].toString()),
                subtitle: Text(package['location'].toString()),
                trailing: Text(
                  package['price'].toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
