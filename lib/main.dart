import 'package:flutter/material.dart';
import 'LoginScreen.dart';
import 'RegisterScreen.dart';
import 'auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/home': (context) => MessageBoardListScreen(),
        '/register': (context) =>
            // T0D0 create a RegisterScreen
            RegisterScreen(),
      },
    );
  }
}

class MessageBoardListScreen extends StatelessWidget {
  final List<Map<String, String>> messageBoards = [
    {'name': 'General!', 'iconUrl': 'lib/img/general.png'},
    {'name': 'Gaming!', 'iconUrl': 'lib/img/gaming.png'},
    {'name': 'Politics!', 'iconUrl': 'lib/img/politics.png'},
    {'name': 'Questions!', 'iconUrl': 'lib/img/question.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Message Boards'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        itemCount: messageBoards.length,
        itemBuilder: (context, index) {
          var board = messageBoards[index];

          return GestureDetector(
            onTap: () {
              // Navigate to the chat screen for the selected board
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(boardName: board['name']!),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    board['iconUrl']!,
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.width * 0.3,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 10),
                  Text(
                    board['name']!,
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
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

class ChatScreen extends StatelessWidget {
  final String boardName;

  ChatScreen({required this.boardName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(boardName),
      ),
      body: Center(
        child: Text(
          'Welcome to the $boardName chat!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
