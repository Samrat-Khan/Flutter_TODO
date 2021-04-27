import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimeStamp {
  DateTime dateTime = new DateTime.now();
  int timeStamp() {
    return dateTime.microsecondsSinceEpoch;
  }
}

kTaskStyle({required bool needWhite}) => GoogleFonts.lato(
      fontWeight: FontWeight.bold,
      fontSize: 30,
      color: needWhite ? Colors.white : Colors.black,
    );
kListStyle({required bool needWhite}) => GoogleFonts.lato(
      fontSize: 30,
      color: needWhite ? Colors.white : Colors.black,
    );
var kTaskNameStyle = GoogleFonts.lato(
  fontSize: 18,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

var kTaskComplete = GoogleFonts.lato(
  decoration: TextDecoration.lineThrough,
  color: Colors.white70,
  fontSize: 12,
);
var kTaskNotComplete = GoogleFonts.lato(
  color: Colors.white,
  fontSize: 12,
);
InputDecoration kTextFieldDecoration({required String hintText}) {
  return InputDecoration(
    hintText: hintText,
    border: InputBorder.none,
    enabledBorder: InputBorder.none,
  );
}

var kBottomAppBarStyle = GoogleFonts.lato(
  fontWeight: FontWeight.w700,
  fontSize: 18,
  color: Colors.white,
);
kLabelTextStyle({required bool needWhite}) => GoogleFonts.lato(
      color: Color(needWhite ? 0xffffffff : 0xffcbcbcb),
    );
kHintTextStyle({required bool needWhite}) => GoogleFonts.lato(
      color: Color(needWhite ? 0xffffffff : 0xffcbcbcb),
    );

kTaskNowOrComing({required String status}) => GoogleFonts.lato(
      color: Colors.black,
    );

kFullListTask({required dynamic colorCode}) => GoogleFonts.lato(
      fontWeight: FontWeight.w800,
      fontSize: 20,
      color: Color(colorCode),
    );
