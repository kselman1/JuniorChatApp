import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/*
class UsersDrawerWidget extends StatelessWidget{

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    
    
    return SafeArea(
      
      child: Drawer(
        
        child: ListView(
           // Start listing users from the beginning, 1000 at a time.
       //   Listpage =FirebaseAuth.getInstance().listUsers(null);
          while (page != null) {
            for (ExportedUserRecord user : page.getValues()) {
              print("User: " + user.getUid());
          }
           page = page.getNextPage();
            }

// Iterate through all users. This will still retrieve users in batches,
// buffering no more than 1000 users in memory at a time.
          page = FirebaseAuth.getInstance().listUsers(null);
         for (ExportedUserRecord user : page.iterateAll()) {
             print("User: " + user.getUid());
           }

        ),

      ),
    
    
    
    
    );
  }





}