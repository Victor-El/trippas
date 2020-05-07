import 'package:Trippas/models/Trip.dart';
import 'package:Trippas/utils/Util.dart';
import 'package:flutter/material.dart';

import 'package:Trippas/utils/DbUtil.dart';

import 'TripsScreen.dart';

class CreateTripScreen extends StatefulWidget {
  final String activityType;
  final Map<String, dynamic> updateValues;

  CreateTripScreen({this.activityType, this.updateValues});

  @override
  _CreateTripScreenState createState() => _CreateTripScreenState(
        this.updateValues,
        this.activityType,
      );
}

class _CreateTripScreenState extends State<CreateTripScreen> {
  int id;
  String activityType;
  Map<String, dynamic> updateValues;

  TextEditingController departureController;
  TextEditingController destinationController;

  TextEditingController departureDateTextController;
  TextEditingController departureTimeController;

  TextEditingController destinationDateController;
  TextEditingController destinationTimeController;

  bool departureValidate;
  bool destinationValidate;

  DateTime selectedDate;
  TimeOfDay selectedTime;

  DateTime destinationSelectedDate;
  TimeOfDay destinationSelectedTime;

  List<String> tripTypes;
  String selectedTripType;

  _CreateTripScreenState(this.updateValues, this.activityType);

  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    selectedTime = TimeOfDay.now();

    departureController = TextEditingController(text: "");
    destinationController = TextEditingController(text: "");

    departureValidate = true;
    destinationValidate = true;

    destinationSelectedDate = DateTime.now();
    destinationSelectedTime = TimeOfDay.now();

    tripTypes = const <String>["Business", "Education", "Health", "Vacation"];

    departureDateTextController =
        TextEditingController(text: selectedDate.toString().split(" ")[0]);
    departureTimeController = TextEditingController(text: "12:00 PM");

    destinationDateController = TextEditingController(
        text: destinationSelectedDate.toString().split(" ")[0]);
    destinationTimeController = TextEditingController(text: "12:00 PM");

    selectedTripType = tripTypes[0];

    // Update the input fields if the page was opened for update

    if (!(updateValues == null)) {
      id = updateValues["_id"];
      departureController.text = updateValues["_departure"];
      departureDateTextController.text = updateValues["_departureDate"];
      departureTimeController.text = updateValues["_departureTime"];
      destinationController.text = updateValues["_destination"];
      destinationDateController.text = updateValues["_destinationDate"];
      destinationTimeController.text = updateValues["_destinationTime"];
      selectedTripType = updateValues["_tripType"];
    }
  }

  Future<Null> _selectDate(BuildContext context,
      TextEditingController controller, DateTime dateState) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: dateState,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != dateState)
      setState(() {
        setState(() {
          dateState = picked;
          controller.text = dateState.toString().split(" ")[0];
        });
      });
    print(dateState.toString());
  }

  Future<Null> _selectTime(BuildContext context,
      TextEditingController controller, TimeOfDay timeState) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != timeState)
      setState(() {
        setState(() {
          timeState = picked;
          controller.text = timeState.format(context);
        });
      });
    print(timeState.format(context));
  }

  Widget customTextInput(String hintText, String labelText,
      TextEditingController controller, bool validator) {
    var customTextInputWidget = TextField(
      controller: controller,
      decoration: InputDecoration(
        errorText: validator ? null : "Field can not be empty",
        hintText: hintText,
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
      ),
    );
    return customTextInputWidget;
  }

  Padding normalFormPadding(double padding) {
    var paddingWidget = Padding(
      padding: EdgeInsets.all(padding),
    );
    return paddingWidget;
  }

  void addTrip() {
    if (selectedTripType.isEmpty) {
      setState(() {
        selectedTripType = "Business";
      });
    }

    if (departureController.text.isEmpty) {
      setState(() {
        departureValidate = false;
      });
    } else {
      setState(() {
        departureValidate = true;
      });
    }
    if (destinationController.text.isEmpty) {
      setState(() {
        destinationValidate = false;
      });
    } else {
      setState(() {
        destinationValidate = true;
      });
    }

    if (!departureValidate || !destinationValidate) {
      return;
    }

    insertTrip(Trip(
      DateTime.now().millisecondsSinceEpoch,
      departureController.text,
      destinationController.text,
      departureDateTextController.text,
      departureTimeController.text,
      destinationDateController.text,
      destinationTimeController.text,
      selectedTripType,
    ))
        .then((value) => Navigator.push(
        context, navigate(TripsScreen(), context)))
        .catchError((error) => showDialog(
        context: context,
        child: Text(
          error.toString(),
        )));
  }

  void updateTrip() {
    if (selectedTripType.isEmpty) {
      setState(() {
        selectedTripType = "Business";
      });
    }

    if (departureController.text.isEmpty) {
      setState(() {
        departureValidate = false;
      });
    } else {
      setState(() {
        departureValidate = true;
      });
    }
    if (destinationController.text.isEmpty) {
      setState(() {
        destinationValidate = false;
      });
    } else {
      setState(() {
        destinationValidate = true;
      });
    }

    if (!departureValidate || !destinationValidate) {
      return;
    }

    updateTripFromDB(id, Trip(
      id,
      departureController.text,
      destinationController.text,
      departureDateTextController.text,
      departureTimeController.text,
      destinationDateController.text,
      destinationTimeController.text,
      selectedTripType,
    ).toMap())
        .then((value) => Navigator.push(
        context, navigate(TripsScreen(), context)))
        .catchError((error) => showDialog(
        context: context,
        child: Text(
          error.toString(),
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          activityType == null ? "Create a Trip" : "Update Trip",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        //automaticallyImplyLeading: true,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  customTextInput(
                    "Enter Depature",
                    "Enter Depature",
                    departureController,
                    departureValidate,
                  ),
                  normalFormPadding(10.0),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: "Enter Date",
                            labelText: "Enter Date",
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                          controller: departureDateTextController,
                          showCursor: false,
                          onTap: () {
                            _selectDate(context, departureDateTextController,
                                selectedDate);
                          },
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(20.0)),
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: "Enter Time",
                            labelText: "Enter Time",
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                          controller: departureTimeController,
                          showCursor: false,
                          onTap: () {
                            _selectTime(
                                context, departureTimeController, selectedTime);
                          },
                        ),
                      ),
                    ],
                  ),
                  normalFormPadding(10.0),
                  customTextInput(
                    "Enter Destination",
                    "Enter Destination",
                    destinationController,
                    destinationValidate,
                  ),
                  normalFormPadding(10.0),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                            hintText: "Enter Date",
                            labelText: "Enter Date",
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                          controller: destinationDateController,
                          showCursor: false,
                          onTap: () {
                            _selectDate(context, destinationDateController,
                                destinationSelectedDate);
                          },
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(20.0)),
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Enter Time",
                            labelText: "Enter Time",
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                          controller: destinationTimeController,
                          showCursor: false,
                          onTap: () {
                            _selectTime(context, destinationTimeController,
                                destinationSelectedTime);
                          },
                        ),
                      ),
                    ],
                  ),
                  normalFormPadding(10.0),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2.0,
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      shape: BoxShape.rectangle,
                    ),
                    child: DropdownButton(
                      isExpanded: true,
                      value: selectedTripType,
                      hint: Text(
                        "Select Trip Type",
                      ),
                      onChanged: (val) {
                        setState(() {
                          selectedTripType = val;
                        });
                        print(val);
                      },
                      items: tripTypes
                          .map((e) => DropdownMenuItem<String>(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                    ),
                  ),
                  normalFormPadding(10.0),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: RaisedButton(
                        padding: EdgeInsets.all(10.0),
                        onPressed: updateValues == null ? addTrip : updateTrip,
                        child: Text(activityType == null ? "Add Trip" : "Update Trip"),
                        color: Colors.blue,
                        textColor: Colors.white,
                        splashColor: Colors.blueGrey,
                      ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
