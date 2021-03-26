import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:olx/view/Home.dart';

final ThemeData temaPadrao = ThemeData(
  primaryColor: Color(0xff9c27b0),
  accentColor: Color(0xff7b1fa2)
);

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    title: "OLX",
    home: Home(),
    theme: temaPadrao,
    debugShowCheckedModeBanner: false,
  ));
}
