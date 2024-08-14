import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/providers/task_provider.dart';
import 'package:to_do_list/services/database_service.dart';

class TaskScreen extends StatelessWidget{
  final TaskModel? task;

  TaskScreen({super.key,this.task});

  final TextEditingController _nameControlller = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();

  @override
  Widget build(BuildContext context){
    if (task !=null){
      _nameControlller.text= task!.name;
      _descriptionController.text = task!.description;
      _dueDateController.text= task!.duedate.toIso8601String();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(task== null ? 'Create Task': 'Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameControlller,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _dueDateController,
              decoration: const InputDecoration(labelText: 'Due Date'),
              onTap: () async{
                DateTime? pickedDate= await showDatePicker(
                  context: context, 
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(), 
                  lastDate: DateTime(2101)
                  );

                  if(pickedDate !=null){
                  _dueDateController.text =pickedDate.toIso8601String();
                  }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: (){
               if(task==null){
                //Create a new task
                Provider.of<TaskProvider>(context, listen:false).addTask(
                  TaskModel(id: DateTime.now().toString(),
                   description: _descriptionController.text,
                    duedate: DateTime.parse(_dueDateController.text),
                     name: _nameControlller.text),
                );
               } else{
                //Update existing task
                Provider.of<TaskProvider>(context, listen: false).udpateTask(
                TaskModel(id: task!.id,
                 description: _descriptionController.text,
                  duedate: DateTime.parse(_dueDateController.text),
                   name: _nameControlller.text
                   ),
                );
               }
               Navigator.pop(context);
            }, child: Text(task== null ? 'Create' : 'Update'),
            )
          ],
        ),
      ),
    );
  }

}