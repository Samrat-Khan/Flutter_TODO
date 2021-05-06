import 'package:hive/hive.dart';

part "totalTodo.g.dart";

@HiveType(typeId: 0)
class TotalTodo {
  @HiveField(0)
  final int? totalTodo;
  TotalTodo({this.totalTodo});
}
