import 'package:Trippas/routes/SplashScreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      title: "Trip App",
//      theme: ThemeData(
//        //accentColor: Colors.black,
//        //scaffoldBackgroundColor: Colors.brown,
//        //cursorColor: Colors.blue,
//        //textSelectionColor: Colors.pink
//      ),
    );
  }
}
