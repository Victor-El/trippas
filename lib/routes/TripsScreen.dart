import 'package:Trippas/models/Trip.dart';
import 'package:Trippas/utils/Util.dart';
import 'package:Trippas/widgets/TripItem.dart';
import 'package:Trippas/routes/CreateTripScreen.dart';
import 'package:Trippas/widgets/TripListSummary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Trippas/utils/DbUtil.dart';

class TripsScreen extends StatefulWidget {
  @override
  _TripsScreenState createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> {
  List<Trip> trips;

  Future<bool> _pop() async {
    SystemNavigator.pop();
    return false;
  }

  @override
  void initState() {
    trips = [];
    getTrips();
    super.initState();
  }

  getTrips() async {
    getTripsFromDb().then((value) => setState(() {
          trips = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _pop,
      child: Scaffold(
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
            child: trips.isEmpty
                ? Text(
                    'No trips available\n Click the "+" button to add a new trip',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  )
                : Column(
                    children: <Widget>[
                      TripListSummary(
                        message: "Welcome back, User.",
                        title: "Create your trip with us",
                        numOfTrips: trips.length,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, int i) => TripItem(
                            trips[i].id,
                            trips[i].departure,
                            trips[i].destination,
                            trips[i].departureDate,
                            trips[i].departureTime,
                            trips[i].destinationDate,
                            trips[i].destinationTime,
                            trips[i].tripType,
                          ),
                          itemCount: trips.length,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
