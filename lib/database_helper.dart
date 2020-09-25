import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _dbName = "myDatabase.db";
  static final _dbVersion = 1;
  static final _tableName = "myTable";
  static final columnID = "id";
  static final amount = "amount";
  static final isSpent = "isSpent";
  static final date = 'date';

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    //thia was returning null before thus there was no database

    _database = await _initiateDatabase();
    return _database;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);

    //you have to return this 

    return await openDatabase(path, version: _dbVersion,
        onCreate: (Database db, int version) {
      db.execute('''
    CREATE TABLE $_tableName(
    $columnID INTEGER PRIMARY KEY,
    $amount INTEGER,
    $isSpent INTEGER,
    $date TEXT)
    ''');
    });
    // print("___INIT");
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    return await db.query(_tableName);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnID];
    return await db
        .update(_tableName, row, where: '$columnID=?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return db.delete(_tableName, where: '$columnID=?', whereArgs: [id]);
  }
}
