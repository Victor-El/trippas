//import 'package:flutter/cupertino.dart';

import 'dart:async';

import 'package:Trippas/routes/CreateTripScreen.dart';
import 'package:Trippas/routes/TripsScreen.dart';
import 'package:Trippas/utils/DbUtil.dart';
import 'package:Trippas/utils/Util.dart';
import 'package:flutter/material.dart';

class TripItem extends StatelessWidget {
  final int _id;
  final String _departure;
  final String _destination;
  final String _departureDate;
  final String _departureTime;
  final String _destinationDate;
  final String _destinationTime;
  final String _tripType;

  final List<String> actions = const <String>["Update", "Delete"];

  TripItem(
    this._id,
    this._departure,
    this._destination,
    this._departureDate,
    this._departureTime,
    this._destinationDate,
    this._destinationTime,
    this._tripType,
  );

  void handlePopUpClick(String popup, BuildContext context) {
    switch (popup) {
      case "Update":
        // TODO: do something here
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(popup)));
        Navigator.push(
            context,
            navigate(
                CreateTripScreen(
                  activityType: "Update Trip",
                  updateValues: {
                    "_id": _id,
                    "_departure": _departure,
                    "_departureDate": _departureDate,
                    "_departureTime": _departureTime,
                    "_destination": _destination,
                    "_destinationDate": _destinationDate,
                    "_destinationTime": _destinationTime,
                    "_tripType": _tripType,
                  },
                ),
                context));
        break;
      case "Delete":
        // TODO: do something here
        deleteTripFromDB(this._id).then((value) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(popup + "ed"),
          ));
          Timer(Duration(seconds: 3), () {
            Navigator.push(context, navigate(TripsScreen(), context));
          });
        });
        break;
      default:
        print("Switch");
    }
  }

  Color correctColor(String tripType) {
    switch (tripType) {
      case "Business":
        // TODO: do something here.
        return Colors.blue;
        break;
      case "Education":
        // TODO: do something here.
        return Colors.lightBlueAccent;
        break;
      case "Health":
        // TODO: do something here.
        return Colors.yellow.shade800;
        break;
      case "Vacation":
        // TODO: do something here.
        return Colors.pink;
        break;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Card(
      color: Colors.white,
      margin: EdgeInsets.all(10.0),
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: Container(
        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 1.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          _departure,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                      ),
                      Text(
                        _departureDate,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14.0,
                        ),
                      ),
                      Text(
                        _departureTime,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Icon(
                      Icons.flight,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        _destination,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                      ),
                      Text(
                        _destinationDate,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14.0,
                        ),
                      ),
                      Text(
                        _destinationTime,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      color: correctColor(_tripType),
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Text(
                    _tripType,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                PopupMenuButton(
                  onSelected: (e) => handlePopUpClick(e, context),
                  itemBuilder: (context) {
                    return actions
                        .map(
                          (e) => PopupMenuItem<String>(
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
