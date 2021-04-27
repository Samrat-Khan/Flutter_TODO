import 'package:flutter/material.dart';

Row appBar({required bool isCrossNeeded, required BuildContext context}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(width: 25),
      CircleAvatar(
        maxRadius: 15,
        backgroundColor: Colors.transparent,
        backgroundImage: AssetImage("images/todo.png"),
      ),
      Spacer(),
      IconButton(
          icon: Icon(isCrossNeeded ? Icons.close : null),
          onPressed: isCrossNeeded == false
              ? null
              : () {
                  // ignore: unnecessary_statements
                  Navigator.pop(context);
                }),
      SizedBox(width: 25),
    ],
  );
}
