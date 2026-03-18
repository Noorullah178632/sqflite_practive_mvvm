import 'package:sqlite_practice_mvvm/models/data_list_model.dart';
import 'package:sqlite_practice_mvvm/services/sqflite_services.dart';

class SqfliteRepository {
  final SqfliteServices _services = SqfliteServices();
  // ADD USER :with the help of sqflite model we will convert the services data to the toJson() to save data in the table
  Future<void> addTask(DataListModel data) async {
    final userData = data.toMap();
    await _services.addData(userData);
  }
}
