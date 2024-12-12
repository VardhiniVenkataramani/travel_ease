import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WitAiChatScreen extends StatefulWidget {
  @override
  _WitAiChatScreenState createState() => _WitAiChatScreenState();
}

class _WitAiChatScreenState extends State<WitAiChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;

  final String _witToken = 'WOUHEX3Z2UAQLRTK6G2I3PJ3VWQYGCP7'; // Your Wit.ai token

  // Function to send a message to Wit.ai and get a response
  Future<Map<String, dynamic>> _getWitResponse(String message) async {
    final url = Uri.parse('https://api.wit.ai/message?v=20221125&q=${Uri.encodeComponent(message)}');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $_witToken'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to connect to Wit.ai');
    }
  }

  // Function to handle sending messages
  void _sendMessage(String message) async {
    if (message.isEmpty) return;

    setState(() {
      _messages.insert(0, {"role": "user", "content": message});
      _isLoading = true;
    });

    try {
      final witResponse = await _getWitResponse(message);

      // Extract intent and entities from Wit.ai response
      final intents = witResponse['intents'];
      final entities = witResponse['entities'];

      String botResponse = 'Refer to the accessibility resources or contact 044-22650324 for assistance.';
      if (intents.isNotEmpty) {
        final intent = intents[0]['name'];
        botResponse = _generateResponse(intent, entities);
      }

      setState(() {
        _messages.insert(0, {"role": "bot", "content": botResponse});
      });
    } catch (error) {
      setState(() {
        _messages.insert(0, {"role": "bot", "content": "Error: $error"});
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Generate bot response based on intent and entities
  String _generateResponse(String intent, Map<String, dynamic>? entities) {
    switch (intent) {
      case 'book_trip':
        final location = entities?['location']?[0]?['value'] ?? 'a destination';
        final date = entities?['datetime']?[0]?['value'] ?? 'sometime';
        return 'Sure! I’ll help you book a trip to $location on $date.';
      case 'find_buddy':
        final location = entities?['location']?[0]?['value'] ?? 'your trip';
        return 'Let me find a travel buddy for $location!';
      case 'check_package_details':
        final packageName = entities?['package_name']?[0]?['value'] ?? 'this package';
        return 'Here are the details for $packageName.';
      default:
      // Updated default response
        return 'Refer to the accessibility resources or contact 044-22650324 for assistance.';
    }
  }

  // Build chat messages
  Widget _buildMessage(Map<String, String> message) {
    final isUserMessage = message["role"] == "user";

    return Row(
      mainAxisAlignment: isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isUserMessage)
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              child: Icon(Icons.support_agent),
            ),
          ),
        Flexible(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isUserMessage ? Colors.blue.shade100 : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              message["content"] ?? "",
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        if (isUserMessage)
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              child: Icon(Icons.person),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TravelEase Chat'),
        backgroundColor: const Color(0xFF4169E1), // Royal Blue
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessage(_messages[index]);
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    final message = _messageController.text.trim();
                    _messageController.clear();
                    _sendMessage(message);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
