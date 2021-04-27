import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/screens/addTodoTask.dart';
import 'package:todo_app/service/firebaseService.dart';
import 'package:todo_app/widget/appBar.dart';
import 'package:todo_app/widget/taskWidget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            width: _size.width,
            height: _size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                appBar(isCrossNeeded: false, context: context),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: "Task", style: kTaskStyle(needWhite: false)),
                      TextSpan(
                          text: "Lists", style: kListStyle(needWhite: false)),
                    ],
                  ),
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: addTask,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Icon(Icons.add),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text("Add List"),
                  ],
                ),
                Container(
                  width: _size.width * 2,
                  height: _size.height / 2,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("Todo")
                          .orderBy("timeStamp", descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        QuerySnapshot? querySnapshot = snapshot.data;
                        if (!snapshot.hasData) {
                          return Center(
                            child: Text("no Data"),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasData) {
                          return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: querySnapshot!.size,
                            itemBuilder: (context, i) {
                              var data = querySnapshot.docs[i];
                              final String? taskName = data["taskName"];
                              List taskList = data["taskList"];
                              print(taskList);
                              Map<String, dynamic?> dateTime = data["dateTime"];
                              final int? timeStamp = data["timeStamp"];
                              final dynamic colorCode = data["colorCode"];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TaskListWidget(
                                    size: _size,
                                    colorCode: colorCode,
                                    dateTime: dateTime,
                                    taskName: taskName!,
                                    taskList: taskList,
                                    timeStamp: timeStamp!),
                              );
                            },
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Todo todo = Todo();

  addTask() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddTodoTask()));
  }
}
