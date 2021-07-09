import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tech_talk_app/screens/Home.dart';
import 'package:tech_talk_app/screens/Login.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MaterialApp(
    home: Login(),
    debugShowCheckedModeBanner: false,
  ));
}

