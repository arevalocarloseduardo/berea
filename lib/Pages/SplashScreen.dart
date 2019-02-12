import 'dart:async';

import 'package:bereaapp/Pages/MenuScreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String accountStatus = '******';

  @override
  void initState() {
    super.initState();

  

    Timer(
        Duration(seconds: 3),
        () =>Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MenuScreen(0)),
            ) );
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 100.0,
                      child: Image.network("https://scontent.faep9-1.fna.fbcdn.net/v/t1.0-9/1601417_329368603911100_2277162521567646177_n.jpg?_nc_cat=104&_nc_ht=scontent.faep9-1.fna&oh=91cac5bdc81830ce0f9063341f304a30&oe=5CE20482")
                    ),
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    Text("Iglesia Bautista Berea",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ))
                  ],
                )),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text(
                      "Iglesia Bautista Berea",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
