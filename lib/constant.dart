import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimeStamp {
  DateTime dateTime = new DateTime.now();
  int timeStamp() {
    return dateTime.microsecondsSinceEpoch;
  }
}

var kTaskStyle = GoogleFonts.lato(
  fontWeight: FontWeight.bold,
  fontSize: 30,
  color: Colors.black,
);
var kListStyle = GoogleFonts.lato(
  fontSize: 30,
  color: Colors.black,
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
var kLabelTextStyle = GoogleFonts.lato(
  color: Color(0xffcbcbcb),
);
var kHintTextStyle = GoogleFonts.lato(
  color: Color(0xffcbcbcb),
);
