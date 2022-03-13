import 'package:flutter/material.dart';
import 'package:todo_app/screens/main_page_mobile.dart';

import 'constants.dart';


void main() => runApp(const ToDoApp());

class ToDoApp extends StatelessWidget {
  const ToDoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  MainPageMobile(),
      title: 'ToDo App',
      theme: appTheme,
    );
  }
}
