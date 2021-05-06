import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/model/databaseModel.dart';
import 'package:todo_app/model/totalTodo.dart';
import 'package:todo_app/screens/Home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Directory appDir = await getApplicationDocumentsDirectory();
  String? dir = appDir.path;
  Hive.init(dir);
  Hive.registerAdapter(TodoModelAdapter());
  Hive.registerAdapter(TotalTodoAdapter());
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}
