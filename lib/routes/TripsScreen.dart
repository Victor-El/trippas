import 'package:Trippas/Util/Util.dart';
import 'package:Trippas/custom-widgets/TripItem.dart';
import 'package:Trippas/routes/CreateTripScreen.dart';
import 'package:flutter/material.dart';

class TripsScreen extends StatefulWidget {
  @override
  _TripsScreenState createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: "Add a new trip",
        child: Icon(Icons.add),
        onPressed: () => {
          print("Pressed"),
          Navigator.push(context, navigate(CreateTripScreen(), context))
        },
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              TripItem("Lagos", "Umuahia", "11-11-11", "11:34", "23-11-19",
                  "23:00", "Business",),
            ],
          ),
        ),
      ),
    );
  }
}
