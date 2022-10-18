import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:junior_chat_app/screens/welcome_screen.dart';
import 'package:junior_chat_app/screens/login_screen.dart';
import 'package:junior_chat_app/screens/registration_screen.dart';
import 'package:junior_chat_app/screens/chat_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: FirebaseOptions(
      apiKey: "AIzaSyCoku59n1cutUibvphJTMyKr2a5WptpohA",
      appId: "1:41076482467:ios:79bc51830728de9855fa16",
      messagingSenderId: "41076482467",
      projectId: "juniorchatapp",
    ));
  runApp(JuniorChatApp());

}

class JuniorChatApp extends StatefulWidget {
  @override
  State<JuniorChatApp> createState() => _JuniorChatAppState();
}

class _JuniorChatAppState extends State<JuniorChatApp> {
  
 
  @override
  Widget build(BuildContext context) {
   
    return MaterialApp(
    
      initialRoute: FirebaseAuth.instance.currentUser ==null ? WelcomeScreen.id : ChatScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}





