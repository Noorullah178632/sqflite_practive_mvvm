class DataListModel {
  int? id;
  String name;
  String desc;

  DataListModel({required this.id, required this.name, required this.desc});

  //factory contructor to convert Map table into dart instance
  factory DataListModel.fromMap(Map<String, dynamic> data) {
    return DataListModel(
      id: data["id"],
      name: data['name'],
      desc: data["desc"],
    );
  }
  //function that convert dart instance into Map table

  Map<String, dynamic> toMap() {
    return {"id": id, "name": name, "desc": desc};
  }
}
