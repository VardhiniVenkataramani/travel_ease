import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingScreen extends StatefulWidget {
  final Map<String, dynamic> package;

  const BookingScreen({required this.package, Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _specialNeedsController = TextEditingController();
  DateTime? _travelDate;
  bool _includeTravelBuddy = false;
  bool _isLoading = false;

  Future<void> _submitBooking() async {
    if (_formKey.currentState?.validate() ?? false && _travelDate != null) {
      setState(() {
        _isLoading = true;
      });

      try {
        final bookingData = {
          'name': _nameController.text,
          'email': _emailController.text,
          'phone': _phoneController.text,
          'specialNeeds': _specialNeedsController.text,
          'packageName': widget.package['name'],
          'location': widget.package['location'],
          'price': widget.package['price'],
          'date': _travelDate,
          'travelBuddy': _includeTravelBuddy,
          'userId': FirebaseAuth.instance.currentUser?.uid,
        };

        // Save to Firestore
        await FirebaseFirestore.instance.collection('bookings').add(bookingData);

        // Update My Trips
        await FirebaseFirestore.instance.collection('myTrips').add(bookingData);

        if (_includeTravelBuddy) {
          // Navigate to Travel Buddy Request Screen
          Navigator.of(context).pushNamed(
            '/travelbuddy-request',
            arguments: {
              'package': widget.package,
              'userName': _nameController.text,
              'userEmail': _emailController.text,
              'userId': FirebaseAuth.instance.currentUser?.uid,
            },
          );
        } else {
          // Show confirmation message and navigate back
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Booking confirmed!')),
          );
          Navigator.of(context).pushNamed(
            '/booking-confirmation',
            arguments: bookingData,
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Booking failed. Please try again.')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Now'),
        backgroundColor: const Color(0xFF4169E1), // Royal Blue
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Booking for: ${widget.package['name']}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Your Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Your Email'),
                validator: (value) {
                  if (value == null || !value.contains('@')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.length < 10) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _specialNeedsController,
                decoration: const InputDecoration(labelText: 'Special Needs (Optional)'),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Travel Date:'),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            _travelDate = pickedDate;
                          });
                        }
                      },
                      child: Text(
                        _travelDate == null
                            ? 'Select Date'
                            : _travelDate!.toLocal().toString().split(' ')[0],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: _includeTravelBuddy,
                    onChanged: (value) {
                      setState(() {
                        _includeTravelBuddy = value!;
                      });
                    },
                  ),
                  const Text('Include a Travel Buddy'),
                ],
              ),
              const SizedBox(height: 32),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                onPressed: _submitBooking,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4169E1),
                ),
                child: const Text('Confirm Booking'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TravelBuddyRequestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final requestDetails = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Request TravelBuddy'),
        backgroundColor: const Color(0xFF4169E1), // Royal Blue
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Package: ${requestDetails['package']['name']}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Your Message',
                hintText: 'Why do you want a travel buddy?',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Travel Buddy Request Sent!')),
                  );
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4169E1), // Royal Blue
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
