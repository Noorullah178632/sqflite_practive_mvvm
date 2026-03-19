import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_practice_mvvm/models/data_list_model.dart';
import 'package:sqlite_practice_mvvm/view_models/sqflite_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  //fields for textfields
  final nameController = TextEditingController();
  final descController = TextEditingController();
  //user data
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home page "), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextFormField(
            controller: descController,
            decoration: InputDecoration(labelText: 'Description'),
          ),
          SizedBox(height: 10),
          Consumer<SqfliteViewModel>(
            builder: (context, vm, child) {
              return ElevatedButton(
                onPressed: () async {
                  final newTask = DataListModel(
                    id: null, //the Sqflite will handle it byitself
                    title: nameController.text,
                    desc: descController.text,
                  );

                  await vm.addTask(newTask);
                },
                child: vm.isLoading
                    ? CircularProgressIndicator(color: Colors.blue)
                    : Text('Save'),
              );
            },
          ),
        ],
      ),
    );
  }
}
