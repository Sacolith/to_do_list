import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/providers/task_provider.dart';

class TaskScreen extends StatelessWidget{
  final TaskModel? task;

  TaskScreen({super.key,this.task});

  final TextEditingController _nameControlller = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();
  


  @override
  Widget build(BuildContext context){
     bool completionstatus=false;
     Widget childtext=Text(task== null ? 'Create' : 'Update',semanticsLabel: 'Delete');
    if (task !=null){
      _nameControlller.text= task!.name;
      _descriptionController.text = task!.description;
      _dueDateController.text= task!.duedate.toIso8601String();
      completionstatus=task!.isCompleted;
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
            Checkbox(value: completionstatus, onChanged: (bool? value){
               Provider.of<TaskProvider>(context, listen:false).toggleTaskCompletion(task!.id);
            }),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: (){
               if(_nameControlller.text.isEmpty || _descriptionController.text.isEmpty){
                
               return;
               }
               final tm= TaskModel(
                   id: task?.id?? DateTime.now().toString(),
                   description: _descriptionController.text,
                    duedate: DateTime.parse(_dueDateController.text),
                     name: _nameControlller.text,
                     isCompleted: task?.isCompleted ??false,
                     
               );
                
               if(task==null){//add task to database
                Provider.of<TaskProvider>(context, listen:false).addTask(tm);

                //Update existing task
                }
                Provider.of<TaskProvider>(context, listen: false).udpateTask(tm);
                
            Navigator.pop(context);
               
            }, child: childtext,
            
            )
          ],
        ),
      ),
    );
  }

}
