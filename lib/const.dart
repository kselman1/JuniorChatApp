import 'package:flutter/material.dart';


const orangeColor=Color.fromARGB(255, 166, 45, 8);
const darkOrangeColor=Color.fromARGB(255, 126, 34, 5);
const bckolor=Color.fromARGB(255, 6, 30, 40);
const whiteColor=Color.fromARGB(255, 218, 208, 208);


const kSendButtonTextStyle = TextStyle(
  color: orangeColor,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  
  border: Border(
    top: BorderSide(color: orangeColor, width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  
  hintText: 'Enter a value',
  hintStyle: TextStyle(color: whiteColor),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: orangeColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: orangeColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
  ),
);