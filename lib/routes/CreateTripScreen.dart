import 'package:flutter/material.dart';

class CreateTripScreen extends StatefulWidget {
  @override
  _CreateTripScreenState createState() => _CreateTripScreenState();
}

class _CreateTripScreenState extends State<CreateTripScreen> {
  TextEditingController departureDateTextController;
  TextEditingController departureTimeController;

  TextEditingController destinationDateController;
  TextEditingController destinationTimeController;

  DateTime selectedDate;
  TimeOfDay selectedTime;

  DateTime destinationSelectedDate;
  TimeOfDay destinationSelectedTime;

  List<String> tripTypes;
  String selectedTripType;

  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    selectedTime = TimeOfDay.now();

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

  Widget customTextInput(String hintText, String labelText) {
    var customTextInputWidget = TextField(
      decoration: InputDecoration(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create a trip",
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
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: <Widget>[
              customTextInput(
                "Enter Depature",
                "Enter Depature",
              ),
              normalFormPadding(10.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter Date",
                        labelText: "Enter Date",
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      controller: departureDateTextController,
                      showCursor: false,
                      onTap: () {
                        _selectDate(
                            context, departureDateTextController, selectedDate);
                      },
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(20.0)),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter Time",
                        labelText: "Enter Time",
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
              customTextInput("Enter Destination", "Enter Destination"),
              normalFormPadding(10.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        hintText: "Enter Date",
                        labelText: "Enter Date",
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "Enter Time",
                        labelText: "Enter Time",
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                    onPressed: () {},
                    child: Text("Add Trip"),
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
    );
  }
}
