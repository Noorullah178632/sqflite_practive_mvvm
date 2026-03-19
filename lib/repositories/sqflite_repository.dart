import 'package:sqlite_practice_mvvm/models/data_list_model.dart';
import 'package:sqlite_practice_mvvm/services/sqflite_services.dart';

class SqfliteRepository {
  final SqfliteServices _services = SqfliteServices();
  // ADD USER :with the help of sqflite model we will convert the services data to the toJson() to save data in the table
  Future<void> addTask(DataListModel data) async {
    final userData = data.toMap();
    await _services.addData(userData);
  }

  //Fetch data:
  Future<List<DataListModel>> fetchData() async {
    final List<Map<String, dynamic>> mapData = await _services.fetchData();
    return mapData.map((newTask) => DataListModel.fromMap(newTask)).toList();
  }

  //update Data :
  Future<int> updateData(DataListModel data) async {
    final userData = data.toMap();
    return await _services.updateData(userData);
  }

  //delete Data:
  Future<int> deleteData(int id) async {
    return await _services.deleteData(id);
  }
}
