import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/providers/task_provider.dart';
import 'package:to_do_list/screens/task_screen.dart';

class Tasktile extends StatelessWidget{
  final TaskModel task;

  const Tasktile({required this.task, super.key});

  @override
  Widget build(BuildContext context){
    return ListTile(
      title: Text(task.name),
      subtitle: Text(task.description),
      trailing: Checkbox(
        value: task.isCompleted,
        onChanged: (bool? value){
          Provider.of<TaskProvider>(context, listen:false).toggleTaskCompletion(task.id);
        },
      ),
      onTap: () {
        Navigator.push(context,
         MaterialPageRoute(builder: (context)=> TaskScreen(task: task)
         )
         );
      },
    );
  }
}