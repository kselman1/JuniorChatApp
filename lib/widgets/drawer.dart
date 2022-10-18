import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:junior_chat_app/const.dart';

import '../data.dart';

var time=DateTime.now();
final tenMinutes = time.add(const Duration(minutes: 15));

class UsersDrawerWidget extends StatelessWidget {
  const UsersDrawerWidget({super.key});
  
  @override
  Widget build(BuildContext context) {

   CollectionReference collection = FirebaseFirestore.instance.collection('Users');
    return StreamBuilder<QuerySnapshot>(
        stream: collection.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return const Text("There is no expense");
         
 
          return Drawer(
            backgroundColor: whiteColor,
               
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                       DrawerHeader(
                        decoration: const BoxDecoration(
                      color: bckolor,
                    ),
                    padding: const EdgeInsets.all(0),
                    margin: const EdgeInsets.all(0),
                    child: Column(
                      children: [
                        const Image(
                          width: 130.0,
                          image: AssetImage('assets/images/logo.png'),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Text(
                          'Users',
                          style: const TextStyle(
                            fontSize: 18,
                            color: orangeColor,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                              
                      ...getExpenseItems(snapshot)
                    ],
                  ),
              
              
            
           );
        });
  }
  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data?.docs.map<Widget>((doc) => ListTile(
      title: Text(
        doc["Username"],
        style: const TextStyle(
          color: bckolor,
          fontSize: 15,
          ),
        ),
      
        )
      ).toList();
  }

  
  

}