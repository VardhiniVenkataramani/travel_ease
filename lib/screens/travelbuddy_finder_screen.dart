import 'package:flutter/material.dart';

class TravelBuddyFinderScreen extends StatelessWidget {
  final List<Map<String, dynamic>> travelBuddies = [
    {
      'id': 'buddy1',
      'name': 'John Doe',
      'email': 'john@example.com',
      'location': 'Delhi',
      'expertise': 'City Tours',
      'image': 'https://www.freepik.com/free-photo/content-young-man-posing-park_1630519.htm#fromView=search&page=1&position=1&uuid=0448ed7c-e599-4d78-8468-3b920e2a81df',
    },
    {
      'id': 'buddy2',
      'name': 'Jane Smith',
      'email': 'jane@example.com',
      'location': 'Mumbai',
      'expertise': 'Beach Destinations',
      'image': 'https://www.freepik.com/free-photo/happy-woman-celebrating-holi-with-color_6043610.htm#fromView=search&page=1&position=0&uuid=e7f6344d-6941-4910-8d3d-5260e337dac8',
    },
    {
      'id': 'buddy3',
      'name': 'Rahul Sharma',
      'email': 'rahul@example.com',
      'location': 'Kolkata',
      'expertise': 'Cultural Trips',
      'image': 'https://img.freepik.com/free-photo/handsome-man-holding-his-hands-crossed_144627-4298.jpg?t=st=1732593029~exp=1732596629~hmac=239c3dca7b1077029cfa61e8ee6194fe9b2c49d920cb3482472754f979461f03&w=360',
    },
    {
      'id': 'buddy4',
      'name': 'Priya Mehta',
      'email': 'priya@example.com',
      'location': 'Chennai',
      'expertise': 'Adventure Tours',
      'image': 'https://img.freepik.com/free-photo/writing-dairy-note-coffee-shop-concept-as-memory-life-woman-coffee-shop-smiling-woman-making-notes-notepad_1153-8262.jpg?t=st=1732593091~exp=1732596691~hmac=fca95721e1707fb51899cfd402fb13142c841778877d3b0125cadb01362f36b0&w=996',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel Buddy Finder'),
        backgroundColor: const Color(0xFF4169E1), // Royal Blue
      ),
      body: ListView.builder(
        itemCount: travelBuddies.length,
        itemBuilder: (context, index) {
          final buddy = travelBuddies[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                '/travelbuddy-detail',
                arguments: buddy,
              );
            },
            child: Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(buddy['image']!),
                ),
                title: Text(buddy['name']),
                subtitle: Text(
                  '${buddy['location']} - ${buddy['expertise']}',
                  style: const TextStyle(color: Colors.grey),
                ),
                trailing: const Icon(Icons.arrow_forward, color: Color(0xFF4169E1)),
              ),
            ),
          );
        },
      ),
    );
  }
}
