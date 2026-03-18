import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class SqfliteServices {
  Database? _database;
  //first get the Database
  Future<Database> get database async {
    if (_database != null) return _database!;
    final db = await _initDB();
    return db;
  }

  //Locate path and open Database
  Future<Database> _initDB() async {
    //locate path
    String path = join(await getDatabasesPath(), "task.db");
    //open database
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
         CREATE TABLE userData(
         id INTEGER PRIMARY KEY AUTOINCREMENT,
         title TEXT,
         desc TEXT
         );

  ''');
      },
    );
  }
  //insert data in the database SQflite

  Future<void> addData(Map<String, dynamic> data) async {
    final db = await database; //get you getter database
    await db.insert(
      "userData",
      data,
      conflictAlgorithm:
          ConflictAlgorithm.replace, //this will replace the data with the id
    );
  }
}
