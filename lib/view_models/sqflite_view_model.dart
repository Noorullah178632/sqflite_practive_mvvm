import 'package:flutter/foundation.dart';
import 'package:sqlite_practice_mvvm/models/data_list_model.dart';
import 'package:sqlite_practice_mvvm/repositories/sqflite_repository.dart';

class SqfliteViewModel extends ChangeNotifier {
  //List for storing all the Data
  List<DataListModel> dataList = [];
  //make a instance of repository
  final SqfliteRepository _repository = SqfliteRepository();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  //add task or userData
  Future<void> addTask(DataListModel data) async {
    setLoading(true);
    await _repository
        .addTask(data)
        .then((value) {
          setLoading(false);
          if (kDebugMode) {
            print("Data:$data");
          }
        })
        .onError((error, stack) {
          setLoading(false);
          if (kDebugMode) {
            print("Error: $error issue found");
          }
        });
  }

  //fetch Data
  Future<void> fetchData() async {
    setLoading(true);
    final data = await _repository
        .fetchData()
        .then((value) {
          dataList = value;
          setLoading(false);
          if (kDebugMode) {
            print("data successfully fetched :${dataList.length} item found");
          }
        })
        .onError((error, stack) {
          setLoading(false);
          if (kDebugMode) {
            print("Error: $error issue found");
          }
        });
  }

  Future<void> update(DataListModel data) async {
    setLoading(true);
    await _repository
        .updateData(data)
        .then((value) {
          setLoading(false);
          if (kDebugMode) {
            print("data successfully updated");
          }
        })
        .onError((error, stack) {
          setLoading(false);
          if (kDebugMode) {
            print("Error: $error issue found");
          }
        });
  }

  //delete Function :
  Future<void> deleteData(int id) async {
    setLoading(true);
    await _repository
        .deleteData(id)
        .then((value) {
          fetchData();
          setLoading(false);
          if (kDebugMode) {
            print("data successfully deleted");
          }
        })
        .onError((error, stack) {
          setLoading(false);
          if (kDebugMode) {
            print("Error: $error issue found");
          }
        });
  }
}
