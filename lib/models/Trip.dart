class Trip {
  int _id;
  String _departure;
  String _destination;
  String _departureDate;
  String _departureTime;
  String _destinationDate;
  String _destinationTime;
  String _tripType;

  Trip(
    this._id,
    this._departure,
    this._destination,
    this._departureDate,
    this._departureTime,
    this._destinationDate,
    this._destinationTime,
    this._tripType,
  );

  int get id => _id;

  String get departure => _departure;

  String get destination => _destination;

  String get departureDate => _departureDate;

  String get departureTime => _departureTime;

  String get destinationDate => _destinationDate;

  String get destinationTime => _destinationTime;

  String get tripType => _tripType;

  Map<String, dynamic> toMap() {
    return {
      "_id" : _id,
      "_departure" : _departure,
      "_destination" : _destination,
      "_departureDate" : _departureDate,
      "_departureTime" : _departureTime,
      "_destinationDate" : _destinationDate,
      "_destinationTime" : _destinationTime,
      "_tripType": _tripType,
    };
  }

  @override
  String toString() {
    return 'Trip{_id: $_id, _departure: $_departure, _destination: $_destination, _departureDate: $_departureDate, _departureTime: $_departureTime, _destinationDate: $_destinationDate, _destinationTime: $_destinationTime, _tripType: $_tripType}';
  }
}
