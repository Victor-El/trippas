import 'dart:async';

import 'package:Trippas/models/Trip.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String dbName = "trip_database";
final String tableName = "trips";
final String createTableQuery =
    "CREATE TABLE trips(_id INTEGER PRIMARY KEY, _departure TEXT, _destination TEXT, _departureDate TEXT, _departureTime TEXT, _destinationDate TEXT, _destinationTime TEXT, _tripType TEXT)";

Future<Database> getDatabase() async {
  final Future<Database> database =
      openDatabase(join(await getDatabasesPath(), dbName));
  return database;
}

Future<Database> createDatabaseTable() async {
  final database = openDatabase(
    join(await getDatabasesPath(), dbName),
    version: 1,
    onCreate: (db, version) {
      return db.execute(createTableQuery);
    },
  );
  return database;
}

Future<void> insertTrip(Trip trip) async {
  createDatabaseTable();
  final db = await getDatabase();
  await db.insert(
    tableName,
    trip.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  db.close();
}

Future<List<Trip>> getTripsFromDb() async {
  createDatabaseTable();
  final db = await getDatabase();
  final List<Map<String, dynamic>> tripResults = await db.query(
    tableName,
  );

  final list = List.generate(
      tripResults.length,
      (index) => Trip(
            tripResults[index]["_id"],
            tripResults[index]["_departure"],
            tripResults[index]["_destination"],
            tripResults[index]["_departureDate"],
            tripResults[index]["_departureTime"],
            tripResults[index]["_destinationDate"],
            tripResults[index]["_destinationTime"],
            tripResults[index]["_tripType"],
          ));
  return list;
}

Future<int> deleteTripFromDB(int id) async {
  final db = await getDatabase();

  return await db.delete(tableName, where: "_id = ?", whereArgs: [id]);
}

Future<int> updateTripFromDB(int id, Map<String, dynamic> map) async {
  final db = await getDatabase();
  final usableMap = map;
  usableMap.remove("_id");

  return await db.update(
    tableName,
    usableMap,
    where: "_id = ?",
    whereArgs: [id],
  );
}
