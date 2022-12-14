import 'package:flutter/material.dart';
import 'package:junior_chat_app/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:junior_chat_app/screens/welcome_screen.dart';
import '../widgets/drawer.dart';

final _firestore = FirebaseFirestore.instance;
User? loggedInUser;
var time=DateTime.now();

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  

  late String messageText;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }
   
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser!;
   
        loggedInUser = user;
      
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
         leading: Builder(
            builder: (context) => InkWell(
              onTap: () => Scaffold.of(context).openDrawer(),
             child: const Icon(
              Icons.chat,
              color: Colors.white,
             size: 25.0,
              ),

            ),
          ),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.logout_rounded),
              onPressed: () {
                _auth.signOut();
                Navigator.pushNamedAndRemoveUntil(context, WelcomeScreen.id, (route) => false);
              }),
        ],
        title: const Text('Chat'),
        backgroundColor: const Color.fromARGB(255, 16, 11, 11),
       
      ),
      drawer:  const UsersDrawerWidget(),

      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
            
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageTextController.clear();
                      _firestore.collection('Messages').add({
                        'text': messageText,
                        'sender': loggedInUser?.email,
                        'time':time
                      });
                    
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection("Messages").orderBy('time',descending: false).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: orangeColor,
            ),
          );
        }
        final messages = snapshot.data!.docs.reversed;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          final messageText =(message.data() as Map<String, dynamic>)['text'];
          final messageSender = (message.data() as Map<String, dynamic>)['sender'];

          final currentUser = loggedInUser?.email;

          final messageBubble = MessageBubble(
            sender: messageSender,
            text: messageText,
            isMe: currentUser == messageSender,
          );

          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
           reverse: true,
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({required this.sender, required this.text, required this.isMe});

  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius: isMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(13.0),
                    bottomLeft: Radius.circular(13.0),
                    bottomRight: Radius.circular(13.0))
                : const BorderRadius.only(
                    bottomLeft: Radius.circular(13.0),
                    bottomRight: Radius.circular(13.0),
                    topRight: Radius.circular(13.0),
                  ),
            elevation: 5.0,
            color: isMe ? orangeColor : bckolor,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(
                  color: isMe ? whiteColor : whiteColor,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}