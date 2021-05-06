// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'databaseModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoModelAdapter extends TypeAdapter<TodoModel> {
  @override
  final int typeId = 0;

  @override
  TodoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodoModel(
      colorCode: fields[2] as dynamic,
      taskExecuteDate: fields[4] as DateTime?,
      taskList: (fields[1] as Map).cast<String, dynamic>(),
      timeStamp: fields[3] as int?,
      todoTitle: fields[0] as String?,
      uniqueId: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TodoModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.todoTitle)
      ..writeByte(1)
      ..write(obj.taskList)
      ..writeByte(2)
      ..write(obj.colorCode)
      ..writeByte(3)
      ..write(obj.timeStamp)
      ..writeByte(4)
      ..write(obj.taskExecuteDate)
      ..writeByte(5)
      ..write(obj.uniqueId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
