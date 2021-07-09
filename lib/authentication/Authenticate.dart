import 'package:tech_talk_app/screens/Home.dart';
import 'package:tech_talk_app/screens/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/Home.dart';
import '../services/userService.dart';

login(email, password, context) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => Navigator.push(
        context, new MaterialPageRoute(builder: (context) => Home())));
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("No user found")));
    } else if (e.code == 'wrong-password') {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Invalid user credentials")));
    }
  }
}

register(email, password, name, context) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => {
      addUser(email, name)
          .then((value) => Navigator.push(context,
          new MaterialPageRoute(builder: (context) => Login())))
          .catchError((onError) => print("Error: $onError"))
    })
        .catchError((onError) => print("Error: $onError"));
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Password is too weak")));
    } else if (e.code == 'email-already-in-use') {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Email already taken")));
    }
  } catch (e) {
    print(e);
  }
}

signout(context) async {
  await FirebaseAuth.instance.signOut().then((value) => {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => Login()), (route) => false)
  });
}

currentUser() {
  return FirebaseAuth.instance.currentUser!.email.toString();
}

isAuthenticated(context) {
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => Login()));
    }
  });
}