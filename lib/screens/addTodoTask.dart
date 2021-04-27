import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/service/firebaseService.dart';
import 'package:todo_app/widget/appBar.dart';

class AddTodoTask extends StatefulWidget {
  @override
  _AddTodoTaskState createState() => _AddTodoTaskState();
}

class _AddTodoTaskState extends State<AddTodoTask> {
  TextEditingController _taskName = TextEditingController();
  TextEditingController _taskList = TextEditingController();
  Random random = Random();
  List<String?> extractedTaskList = [];
  bool _isUploading = false;

  List<dynamic> colorCode = [
    0xffff2e44,
    0xffffe546,
    0xff1440a1,
    0xff504da6,
    0xfff374c1,
    0xfffabb18
  ];
  dynamic? selectedColorCode;

  @override
  void dispose() {
    super.dispose();
    _taskList.dispose();
    _taskName.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor:
            selectedColorCode == null ? Colors.white : Color(selectedColorCode),
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: SingleChildScrollView(
          child: Container(
            width: _size.width,
            height: _size.height,
            child: _isUploading
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      backgroundColor: Colors.white,
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      appBar(isCrossNeeded: true, context: context),
                      SizedBox(height: 35),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(text: "New", style: kListStyle),
                          TextSpan(text: "Task", style: kTaskStyle),
                        ]),
                      ),
                      SizedBox(height: 50),
                      Container(
                        width: _size.width / 1.3,
                        child: TextField(
                          keyboardType: TextInputType.text,
                          controller: _taskName,
                          decoration: InputDecoration(
                            hintText: "Goto Supermarket",
                            hintStyle: kHintTextStyle,
                            labelText: "Task Name",
                            labelStyle: kLabelTextStyle,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xffcbcbcb),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      Container(
                        width: _size.width / 1.3,
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          controller: _taskList,
                          maxLines: 10,
                          decoration: InputDecoration(
                            hintText: "Task List",
                            hintStyle: kHintTextStyle,
                            labelText: "Example: Buy 1kg Sugar, 2pc Chocolate",
                            labelStyle: kLabelTextStyle,
                            helperText:
                                " Add Comma(,) after every task name ex. Chocolate, Lase",
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xffcbcbcb),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Center(
                        child: Text(
                          "Select One Color",
                          style: GoogleFonts.lato(fontWeight: FontWeight.w800),
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: _size.width,
                        padding: EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            for (var color in colorCode)
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedColorCode = color;
                                  });
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  child: Card(
                                    color: Color(color),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
        bottomNavigationBar: GestureDetector(
          onTap: addTaskToFirebase,
          child: BottomAppBar(
            color: Color(0xff5886fe),
            elevation: 5,
            child: Container(
              height: 50,
              child: Center(
                child: Text(
                  "Add Task",
                  style: kBottomAppBarStyle,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Todo todo = Todo();
  addTaskToFirebase() async {
    setState(() {
      _isUploading = true;
    });
    extractedTaskList = _taskList.text.split(',');
    try {
      await todo
          .addTodo(
              tasks: extractedTaskList,
              taskName: _taskName.text,
              color: selectedColorCode == null
                  ? colorCode[random.nextInt(5)]
                  : selectedColorCode!,
              timestamp: DateTime.now().microsecondsSinceEpoch,
              context: context)
          .whenComplete(() => {
                _taskName.clear(),
                _taskList.clear(),
              });
      setState(() {
        _isUploading = false;
      });
      Navigator.pop(context);
    } catch (e) {
      setState(() {
        _isUploading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        Todo.showErrorMessage(message: e.toString()),
      );
    }
  }
}
