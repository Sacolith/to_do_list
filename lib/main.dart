

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/design/colors.dart';
import 'package:to_do_list/providers/task_provider.dart';
import 'package:to_do_list/screens/home_screen.dart';


 main() {

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: 
    [
    ChangeNotifierProvider(create: (_)=> TaskProvider(),)
    ],
    child:   MaterialApp(
      title: 'Task Management App',
      theme: _thym(),
      home: const HomeScreen(),
    ),
    );
  }
}

ThemeData _thym(){
  return ThemeData(
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      backgroundColor: Cols.primaryBG,
      elevation: 0
    ),
  scaffoldBackgroundColor: Cols.primaryBG  ,
  focusColor: Cols.focuscolor,
  );
  }