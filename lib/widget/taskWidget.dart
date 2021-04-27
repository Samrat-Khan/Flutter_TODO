import 'package:flutter/material.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/screens/showFullTask.dart';
import 'package:todo_app/service/monthConverter.dart';

class TaskListWidget extends StatefulWidget {
  TaskListWidget({
    Key? key,
    required Size size,
    required Map<String, dynamic?> this.dateTime,
    required this.colorCode,
    required this.taskName,
    required this.taskList,
    required this.timeStamp,
  })   : _size = size,
        super(key: key);

  final Size _size;
  final colorCode;
  final String taskName;
  final List taskList;
  final int timeStamp;
  final Map dateTime;

  @override
  _TaskListWidgetState createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  String? taskStatus, monthInWord;
  ConvertMonth convertMonth = ConvertMonth();
  @override
  void initState() {
    super.initState();
    getTaskStatus();
  }

  getTaskStatus() {
    taskStatus = convertMonth.compareDate(
        day: widget.dateTime["day"],
        month: widget.dateTime["month"],
        year: widget.dateTime["year"]);
    monthInWord = convertMonth.monthConvert(month: widget.dateTime["month"]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget._size.width / 1.7,
      height: widget._size.height,
      decoration: BoxDecoration(
        color: Color(widget.colorCode),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 20, top: 20),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.taskName,
                style: kTaskNameStyle,
                softWrap: true,
              ),
              SizedBox(height: 10),
              Divider(
                color: Colors.white,
              ),
              Hero(
                tag: "listHero",
                child: Container(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: widget.taskList.length,
                    itemBuilder: (context, i) {
                      String? taskTodoName = widget.taskList[i]["taskName"];
                      return Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: ListTile(
                          title: Text(
                            taskTodoName!,
                            style: kTaskNotComplete,
                            softWrap: true,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              widget.taskList.length < 4
                  ? SizedBox()
                  : TextButton(
                      child: Text("Click to see full", style: kTaskNotComplete),
                      onPressed: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 1000),
                            pageBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation) {
                              return FullTask(
                                taskList: widget.taskList,
                              );
                            },
                            transitionsBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation,
                                Widget child) {
                              return Align(
                                child: FadeTransition(
                                  opacity: animation,
                                  child: child,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    taskStatus!,
                    softWrap: true,
                    style: kTaskNotComplete,
                  ),
                  Text(
                      "${widget.dateTime["day"]}, $monthInWord ${widget.dateTime["year"]}",
                      style: kTaskNotComplete),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
