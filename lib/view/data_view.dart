import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_practice_mvvm/models/data_list_model.dart';
import 'package:sqlite_practice_mvvm/view_models/sqflite_view_model.dart';

class DataView extends StatefulWidget {
  const DataView({super.key});

  @override
  State<DataView> createState() => _DataViewState();
}

class _DataViewState extends State<DataView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SqfliteViewModel>(context, listen: false).fetchData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("View Page "), centerTitle: true),
      body: Consumer<SqfliteViewModel>(
        builder: (context, vm, child) {
          return ListView.builder(
            itemCount: vm.dataList.length,
            itemBuilder: (context, index) {
              return Card(
                borderOnForeground: true,
                shadowColor: Colors.blue,
                child: ListTile(
                  title: Text(vm.dataList[index].title),
                  subtitle: Text(vm.dataList[index].desc),
                  trailing: Row(
                    mainAxisSize: MainAxisSize
                        .min, // Vital: Keeps the row from taking full width
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          showEditDialog(
                            context,
                            vm,
                            vm.dataList[index].id!,
                            vm.dataList[index].title,
                            vm.dataList[index].desc,
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          await vm.deleteData(vm.dataList[index].id!);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void showEditDialog(
    BuildContext context,
    SqfliteViewModel vm,
    int id,
    String title,
    String description,
  ) {
    final titleController = TextEditingController(text: title);
    final desController = TextEditingController(text: description);
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Record"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: desController,
              decoration: InputDecoration(labelText: "Description"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              final updateData = DataListModel(
                id: id,
                title: titleController.text,
                desc: desController.text,
              );

              vm.update(updateData);
              Navigator.pop(context); // Close dialog
            },
            child: Text("Update"),
          ),
        ],
      ),
    );
  }
}
