import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_list/models/task.dart';

class DatabaseS{
  static final DatabaseS _instance= DatabaseS._internal();
  factory DatabaseS()=> _instance;
  DatabaseS._internal();

  static Database? _database;

  Future<Database> get database async{
    if(_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
    }

    Future<Database> _initDatabase() async{
     try{ String path= join(await getDatabasesPath(),'task.db' );
      return await openDatabase(
        path,
        onCreate: (db,version){
          return db.execute(
            'Create TABLE tasks(id TEXT PRIMARY KEY,name TEXT, description TEXT, dueDate TEXT,isCompleted INTEGER)'
          );
        },
        version: 1,
        );
        } catch(e){
           debugPrint("error initializing database: $e");
      throw Exception("Error initializing database: $e");
        }
    }

    Future<void> insertTask(TaskModel task) async{
      final db= await database;
      await db.insert('tasks',task.tasks(), conflictAlgorithm: ConflictAlgorithm.replace);
    }

    Future<List<TaskModel>> tasks() async{
    final db= await database;
    final List<Map<String,dynamic>> maps = await db.query('tasks');

    return List.generate(maps.length,(i){
      return TaskModel.fromMap(maps[i]);
    });
    }

    Future<void> updateTask(TaskModel task) async{
      final db= await database;
      await db.update('tasks',task.tasks(),where:"id=?", whereArgs:[task.id],);
      debugPrint('Working');
      
    }

    Future<void> deleteTask(String id) async{
      final db = await database;
      await db.delete('tasks', where: 'id=?',whereArgs: [id]);
    }
}