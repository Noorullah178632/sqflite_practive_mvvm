import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqlite_practice_mvvm/models/data_list_model.dart';
import 'package:sqlite_practice_mvvm/repositories/sqflite_repository.dart';

class SqfliteViewModel extends ChangeNotifier {
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
}
