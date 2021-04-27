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
  DateTime finalDateTime = DateTime.now();
  List<dynamic> colorCode = [
    0xffff2e44,
    0xff27ad61,
    0xff1440a1,
    0xff504da6,
    0xfff374c1,
    0xfffabb18
  ];
  dynamic? selectedColorCode;
  bool colorIsSelectByUser = false;
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
                          TextSpan(
                              text: "New",
                              style:
                                  kListStyle(needWhite: colorIsSelectByUser)),
                          TextSpan(
                              text: "Task",
                              style:
                                  kTaskStyle(needWhite: colorIsSelectByUser)),
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
                            hintStyle:
                                kHintTextStyle(needWhite: colorIsSelectByUser),
                            labelText: "Task Name",
                            labelStyle:
                                kLabelTextStyle(needWhite: colorIsSelectByUser),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(colorIsSelectByUser
                                    ? 0xffffffff
                                    : 0xffcbcbcb),
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
                          maxLines: 8,
                          decoration: InputDecoration(
                            hintText: "Task List",
                            hintStyle:
                                kHintTextStyle(needWhite: colorIsSelectByUser),
                            labelText: "Example: Buy 1kg Sugar, 2pc Chocolate",
                            labelStyle:
                                kLabelTextStyle(needWhite: colorIsSelectByUser),
                            helperText:
                                " Add Comma(,) after every task name ex. Chocolate, Lase",
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(colorIsSelectByUser
                                    ? 0xffffffff
                                    : 0xffcbcbcb),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Choose date for this Task"),
                            IconButton(
                              icon: Icon(Icons.calendar_today),
                              onPressed: clickCalender,
                            ),
                          ],
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
                                    colorIsSelectByUser = true;
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
  clickCalender() async {
    final DateTime? pickedDateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        lastDate: DateTime(2099));
    if (pickedDateTime != null && pickedDateTime != finalDateTime) {
      setState(() {
        finalDateTime = pickedDateTime;
      });
    }
  }

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
              day: finalDateTime.day,
              month: finalDateTime.month,
              year: finalDateTime.year,
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
