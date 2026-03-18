class DataListModel {
  final int? id;
  final String title;
  final String desc;

  DataListModel({required this.id, required this.title, required this.desc});

  //factory contructor to convert Map table into dart instance
  factory DataListModel.fromMap(Map<String, dynamic> data) {
    return DataListModel(
      id: data["id"],
      title: data['title'],
      desc: data["desc"],
    );
  }
  //function that convert dart instance into Map table

  Map<String, dynamic> toMap() {
    return {"id": id, "title": title, "desc": desc};
  }

  //to see the actual data of the user
  @override
  String toString() {
    return "userData(id: $id , title :$title , description : $desc)";
  }
}
