import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Todo {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future addTodo(
      {required List<String?> tasks,
      required int timestamp,
      required dynamic color,
      required int day,
      required int month,
      required int year,
      required BuildContext context,
      required String taskName}) async {
    Set<Map<String, dynamic?>> map = {
      for (var val in tasks) {'taskName': val}
    };
    List<Map<String, dynamic?>> finalTaskList = map.toList();

    try {
      await _firestore.collection("Todo").doc(timestamp.toString()).set({
        "taskList": finalTaskList,
        "taskName": taskName,
        "timeStamp": timestamp,
        "colorCode": color,
        "dateTime": {"day": day, "month": month, "year": year}
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        Todo.showErrorMessage(message: "An error occurred"),
      );
    }
  }

  Future deleteTodo(
      {required BuildContext context, required int timestamp}) async {
    try {
      await _firestore.collection("Todo").doc(timestamp.toString()).delete();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        Todo.showErrorMessage(message: "An error occurred"),
      );
    }
  }

  static showErrorMessage({required String message}) {
    return SnackBar(
      elevation: 5,
      duration: Duration(seconds: 10),
      content: Text(
        message,
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
    );
  }
}
