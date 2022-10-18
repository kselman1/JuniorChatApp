import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:junior_chat_app/data.dart';
import 'package:junior_chat_app/rounded_button.dart';
import 'package:junior_chat_app/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:junior_chat_app/screens/welcome_screen.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

var newTime=DateTime.now();

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  
  
   


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bckolor,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 200.0,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                style: const TextStyle(color: whiteColor),
                onChanged: (value) {
                  email = value;
                },
             
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                style: const TextStyle(color: whiteColor),
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),

               
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Log In',
                colour: orangeColor,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                 
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title:  Text('$e'),
                  content: const Text("Please try again."),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        Navigator.pushNamed(context, WelcomeScreen.id);
                      },
                      child: Container(
                        color: orangeColor,
                        
                        padding: const EdgeInsets.all(12),
                        child: const Text(
                          "OK",
                          style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: bckolor,
                          fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),);
                    print(e);
                    
                  }
                 
                },
                
              ),
            ],
          ),
        ),
      ),
    );
  }
}