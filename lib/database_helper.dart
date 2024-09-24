import "dart:async";
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _dbname = "myDatabase.db";
  static const _dbversion = 1;
  static const _tableName = "userDetails";

  static const columnUsername = "_username";
  static const columnfirstName = "_firstName";
  static const columnlastName = "_lastName";
  static const columngender = "_gender";
  static const columndob = "_dob";
  static const columnexperience = "_experience";
  static const columnpassword = "_password";

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static late Database _database;

  // making it a singleton class
  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    return _database;
  }

  // insert a row in the table

  // ignore: unused_element
  Future insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_tableName, row);
  }

  // returns all the data in the form of list

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    return await db.query(_tableName);
  }

  _initateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbname);
    return await openDatabase(path, version: _dbversion, onCreate: _onCreate);
  }

  // create a table in the database

  Future _onCreate(Database db, int version) async {
    await db.execute('''
            CREATE TABLE $_tableName(
              $columnUsername TEXT Not NULL,
              $columnfirstName TEXT Not NULL,
              $columnlastName TEXT Not NULL,
              $columngender TEXT Not NULL,
              $columndob TEXT Not NULL,
              $columnexperience INTEGER Not NULL,
              $columnpassword TEXT Not NULL
              
              )

              ''');
  }
}
