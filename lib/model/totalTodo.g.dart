// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'totalTodo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TotalTodoAdapter extends TypeAdapter<TotalTodo> {
  @override
  final int typeId = 0;

  @override
  TotalTodo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TotalTodo(
      totalTodo: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, TotalTodo obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.totalTodo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TotalTodoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
