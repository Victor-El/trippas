import 'package:flutter/material.dart';

class TripItem extends StatelessWidget {
  final String _departure;
  final String _destination;
  final String _departureDate;
  final String _departureTime;
  final String _destinationDate;
  final String _destinationTime;
  final String _tripType;

  final List<String> actions = const <String>["Update", "Delete"];

  TripItem(
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
        break;
      case "Delete":
        // TODO: do something here
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(popup)));
        break;
      default:
        print("Switch");
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Card(
      color: Colors.white,
      margin: EdgeInsets.all(15.0),
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  _departure,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  _departureDate,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 10.0,
                  ),
                ),
                Text(
                  _departureTime,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 10.0,
                  ),
                ),
                Text(
                  _tripType,
                  style: TextStyle(
                    color: Colors.black54,
                    backgroundColor: Colors.orange,
                    fontSize: 10.0,
                  ),
                )
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  _destination,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  _destinationDate,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 10.0,
                  ),
                ),
                Text(
                  _destinationTime,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 10.0,
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
            )
          ],
        ),
      ),
    );
  }
}
