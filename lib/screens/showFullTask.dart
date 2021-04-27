import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/widget/appBar.dart';

class FullTask extends StatelessWidget {
  final List taskList;

  FullTask({Key? key, required this.taskList}) : super(key: key);
  final List<dynamic> colorCodeForTaskList = [
    0xffff2e44,
    0xff27ad61,
    0xff1440a1,
    0xff504da6,
    0xfff374c1,
    0xfffabb18
  ];
  final Random random = Random();
  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        body: Hero(
          tag: "listHero",
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              height: _size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  appBar(isCrossNeeded: true, context: context),
                  Text(
                    "My Tasks",
                    style: kTaskStyle(needWhite: false),
                  ),
                  Divider(
                    indent: 70,
                    thickness: 1.2,
                  ),
                  Container(
                    height: 500,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: taskList.length,
                      itemBuilder: (context, i) {
                        String? taskTodoName = taskList[i]["taskName"];
                        return Padding(
                          padding: const EdgeInsets.only(left: 50.0),
                          child: ListTile(
                            title: Text(
                              taskTodoName!,
                              style: kFullListTask(
                                  colorCode:
                                      colorCodeForTaskList[random.nextInt(5)]),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
