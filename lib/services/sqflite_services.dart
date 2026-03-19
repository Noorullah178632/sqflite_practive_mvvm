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

  //fetch  data : query
  Future<List<Map<String, dynamic>>> fetchData() async {
    final db = await database;
    return await db.query("userData");
  }

  //update data :
  Future<int> updateData(Map<String, dynamic> data) async {
    final db = await database;
    return await db.update(
      "userData",
      data,
      where: "id =?",
      whereArgs: [data['id']],
    ); //"id = ?" : mean we can take any id with it // [data[id]]:mean actual id you wanna delete
  }

  //delte data :
  Future<int> deleteData(int id) async {
    final db = await database;
    return await db.delete("userData", where: 'id =?', whereArgs: [id]);
  }
}
