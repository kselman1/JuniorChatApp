import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:username_gen/username_gen.dart';

List<String> activeUsers=[];
String userName='';
String mail='';
String getUsername(){
   
  return UsernameGen().generate();

}

