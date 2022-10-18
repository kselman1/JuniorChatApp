import 'package:flutter/material.dart';
import 'package:junior_chat_app/data.dart';
import 'package:junior_chat_app/rounded_button.dart';
import 'package:junior_chat_app/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:junior_chat_app/screens/welcome_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  late String email;
  late String password;
  String username=getUsername();
  
  final userController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bckolor,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
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
                  setState(() {
                    email = value;
                  });
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
                  setState(() {
                    password = value;
                  });
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              const SizedBox(
                height: 24.0,
              ),
              
              RoundedButton(
                title: 'Register',
                colour: orangeColor,
                
                onPressed: () async {
                 
                      userController.clear();
                      _firestore.collection('Users').add({
                         'Email':email,
                        'Password': password,
                        'Username':username
                       
                      });
                     
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                   

                    showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(

                      title:  Text('Your randomly selected username is $username. Have fun using JCA.'),
                 
                    actions: <Widget>[
                     TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        
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
                    setState(() {
                    showSpinner = false;
                  });

                    
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