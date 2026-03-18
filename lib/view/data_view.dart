import 'package:flutter/material.dart';

class DataView extends StatefulWidget {
  const DataView({super.key});

  @override
  State<DataView> createState() => _DataViewState();
}

class _DataViewState extends State<DataView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("View Page "), centerTitle: true),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Card(
            borderOnForeground: true,
            shadowColor: Colors.blue,
            child: ListTile(
              title: Text('Task Name'),
              subtitle: Text('Task Description'),
              trailing: Row(
                mainAxisSize: MainAxisSize
                    .min, // Vital: Keeps the row from taking full width
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      showEditDialog(context, "Task Name", "Task Description");
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void showEditDialog(BuildContext context, String title, String description) {
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
              Navigator.pop(context); // Close dialog
            },
            child: Text("Update"),
          ),
        ],
      ),
    );
  }
}
