
import 'package:flutter/material.dart';
import 'package:flutterprojects/pages/accepted.dart';
import 'package:flutterprojects/pages/refused.dart';


import 'HomePage.dart';


void main(){
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
    initialRoute: '/' ,
    routes: {
      '/' : (context) => HomePage(),
      '/accepted' : (context) => Accepted(),
      '/refused' : (context) => Refused(),
  }
  ));

}



