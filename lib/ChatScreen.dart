import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  final String boardName;

  ChatScreen({required this.boardName});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _username = '';

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final userId = _auth.currentUser?.uid;
    if (userId != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (userDoc.exists) {
        setState(() {
          _username = userDoc['username'] ?? 'User';
        });
      }
    }
  }

  // Function to send a new message
  void _sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('message_boards')
          .doc(widget.boardName)
          .collection('messages')
          .add({
        'message': _messageController.text,
        'username': _username,
        'datetime': DateTime.now(),
      });
      _messageController.clear();
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.boardName),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('message_boards')
                  .doc(widget.boardName)
                  .collection('messages')
                  .orderBy('datetime', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                final messages = snapshot.data!.docs;

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var messageData = messages[index];
                    var messageText = messageData['message'];
                    var username = messageData['username'];
                    var datetime = messageData['datetime'].toDate();

                    return ListTile(
                      title: Text(
                        username,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(messageText),
                      trailing: Text(
                        '${datetime.hour}:${datetime.minute} - ${datetime.month}/${datetime.day}/${datetime.year}',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter your message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
