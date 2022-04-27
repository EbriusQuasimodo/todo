import 'package:flutter/material.dart';
import 'package:todo/pages/FoodShoppingList.dart';
import 'package:todo/pages/home.dart';
import 'package:todo/pages/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void initFirebase() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

void main() {
  initFirebase();
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.brown[600],
    ),

    initialRoute: '/',
    routes: {
      '/': (context) => MainScreen(),
      '/todo': (context) => Home(),
      '/shoppingFood': (context) => FoodShoppingList(),
    },
  ));
}

