import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/screens/addTodoTask.dart';
import 'package:todo_app/service/firebaseService.dart';
import 'package:todo_app/widget/appBar.dart';

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
                      TextSpan(text: "Task", style: kTaskStyle),
                      TextSpan(text: "Lists", style: kListStyle),
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
                                child: taskListWidget(_size, colorCode,
                                    taskName!, taskList, timeStamp!),
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

  Container taskListWidget(
      Size _size, colorCode, String taskName, List taskList, int timeStamp) {
    return Container(
      width: _size.width / 1.7,
      height: _size.height,
      decoration: BoxDecoration(
        color: Color(colorCode),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 20, top: 20),
        child: Container(
          width: _size.width,
          height: _size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                taskName,
                style: kTaskNameStyle,
                softWrap: true,
              ),
              SizedBox(height: 10),
              Divider(
                color: Colors.white,
              ),
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: taskList.length,
                  itemBuilder: (context, i) {
                    String? taskTodoName = taskList[i]["taskName"];
                    return ListTile(
                      leading: Icon(
                        Icons.note,
                        color: Colors.white,
                      ),
                      title: Text(
                        taskTodoName!,
                        style: kTaskNotComplete,
                        softWrap: true,
                        overflow: TextOverflow.clip,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Todo todo = Todo();
  updateTaskTodo(
      {required int? timestamp,
      required bool? isComplete,
      required int? arrIndex}) async {
    await todo.updateTodo(
        isComplete: isComplete!,
        timestamp: timestamp!,
        arrIndex: arrIndex!,
        context: context);
  }

  addTask() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddTodoTask()));
  }
}
