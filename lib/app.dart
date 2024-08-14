import 'package:flutter/material.dart';
//import 'package:to_do_list/design/colors.dart';
import 'package:to_do_list/screens/home_screen.dart';

class App extends StatelessWidget{
  const App({super.key});


  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Task Management App',
      theme: _thym(),
      home: const HomeScreen(),
    );
  }
}

ThemeData _thym(){
  return ThemeData(
    
  );
}