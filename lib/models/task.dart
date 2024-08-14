class TaskModel{
String name;
String description;
DateTime duedate;
bool isCompleted;
String id;
  TaskModel({
   this.isCompleted=false, required this.id,
    required this.description,required this.duedate, required this.name
  });

  Map<String, dynamic> tasks(){
    return{
      'id':id,
    'name':name,
    'description':description,
     'duedate':duedate.toIso8601String(),
    'isCompleted':isCompleted ? 1:0,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> tmap){
    return TaskModel(
      id: tmap['id'],
      name: tmap['name'],
      description: tmap['description'],
      duedate: DateTime.parse(tmap['dueDate']),
      isCompleted: tmap['isCompleted']==1,
    );
  }
}