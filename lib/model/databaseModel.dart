import 'package:hive/hive.dart';

part "databaseModel.g.dart";

@HiveType(typeId: 0)
class TodoModel {
  @HiveField(0)
  final String? todoTitle;
  @HiveField(1)
  final Map<String, dynamic?> taskList;
  @HiveField(2)
  final dynamic? colorCode;
  @HiveField(3)
  final int? timeStamp;
  @HiveField(4)
  final DateTime? taskExecuteDate;
  @HiveField(5)
  final String? uniqueId;
  TodoModel(
      {this.colorCode,
      this.taskExecuteDate,
      required this.taskList,
      this.timeStamp,
      this.todoTitle,
      this.uniqueId});
}
