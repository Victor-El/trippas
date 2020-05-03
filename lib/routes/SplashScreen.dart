import 'dart:async';

import 'package:flutter/material.dart';
import '../Util/Util.dart';
import 'TripsScreen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Navigator.push(context, navigate(TripsScreen(), context));
      print("Done");
    });
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Text(
            "Trippas",
            style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 50.0),
          ),
        ),
      ),
    );
  }
}
