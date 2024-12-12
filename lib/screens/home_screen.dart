import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TravelEase'),
        backgroundColor: const Color(0xFF4169E1), // Royal Blue
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Navigate to Notifications screen
              Navigator.of(context).pushNamed('/notifications');
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // Navigate to Profile screen
              Navigator.of(context).pushNamed('/profile');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome to TravelEase!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4169E1), // Royal Blue
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Your gateway to accessible and inclusive travel.',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 20),
              GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                children: [
                  _buildFeatureCard(
                    icon: Icons.map,
                    title: 'Tourist Places',
                    onTap: () {
                      Navigator.of(context).pushNamed('/categories');
                    },
                  ),
                  _buildFeatureCard(
                    icon: Icons.group,
                    title: 'TravelBuddy',
                    onTap: () {
                      Navigator.of(context).pushNamed('/travelbuddy-finder');
                    },
                  ),
                  _buildFeatureCard(
                    icon: Icons.trip_origin,
                    title: 'My Trips',
                    onTap: () {
                      Navigator.of(context).pushNamed('/my-trips');
                    },
                  ),
                  _buildFeatureCard(
                    icon: Icons.accessibility,
                    title: 'Accessibility Resources',
                    onTap: () {
                      Navigator.of(context).pushNamed('/accessibility-resources');
                    },
                  ),
                  _buildFeatureCard(
                    icon: Icons.chat,
                    title: 'Chat Assistant',
                    onTap: () {
                      Navigator.of(context).pushNamed('/chat');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF4169E1), // Royal Blue
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
            Icon(icon, color: Colors.white, size: 40),
            const SizedBox(height: 10),
            Text(
              title,
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
  }
}
