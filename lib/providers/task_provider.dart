import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/services/database_service.dart';

class TaskProvider with ChangeNotifier{
  List<TaskModel> _task=[];

  List<TaskModel> get tasks=>_task;

  Future intial ()async{
if(Platform.isWindows || Platform.isLinux)
{sqfliteFfiInit();}
databaseFactory= databaseFactoryFfi;
  }

  void loadTasks() async{
 _task= await DatabaseS().tasks(); 
 notifyListeners();
  }

void addTask(TaskModel task) async{
await DatabaseS().insertTask(task);
_task.add(task);
notifyListeners();
debugPrint('add task from provider');
}

void udpateTask(TaskModel task)async{
await DatabaseS().updateTask(task);
int index = _task.indexWhere((t)=> t.id==task.id);
if(index !=-1){
  _task[index] =task;
  notifyListeners();
  debugPrint('update task from provider');
}
}

  void deleteTasks(String id) async{
await DatabaseS().deleteTask(id);
_task.removeWhere((task)=> task.id==id);
notifyListeners();
debugPrint('delete task from provider');
  }


  void toggleTaskCompletion(String id)async{
 int index = _task.indexWhere((task)=> task.id== id);
 if(index !=-1){
TaskModel taskModel =_task[index];
taskModel= TaskModel(
  id: taskModel.id, 
  description: taskModel.description,
   duedate: taskModel.duedate,
 name: taskModel.name,
 isCompleted: !taskModel.isCompleted
 );
 
  udpateTask(taskModel);
 }
  }
}