import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/providers/task_provider.dart';
import 'package:to_do_list/screens/task_screen.dart';
import 'package:to_do_list/widgets/task_tile.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Management App'),
        actions: const [
         
        ],
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskprovider, child) {
          return ListView.builder(
            itemCount: taskprovider.tasks.length,
            itemBuilder: (context, index){
              return Tasktile(task: taskprovider.tasks[index]);
            });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, 
          MaterialPageRoute(builder: (context)=>TaskScreen())
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}