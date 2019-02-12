
import 'package:bereaapp/Pages/MenuScreen.dart';
import 'package:bereaapp/Pages/SplashScreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  theme: ThemeData(
    primaryColor: Colors.blue,
    accentColor: Colors.blueAccent
    ),
  debugShowCheckedModeBanner: false,
  home: SplashScreen(),
  routes: <String,WidgetBuilder>{
    '/tercero':(BuildContext context)=>MenuScreen(0),
    '/Second':(BuildContext context)=>MenuScreen(0),
  },
  ));
