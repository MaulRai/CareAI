import 'package:flutter/material.dart';

Widget appImage(
    {String imagePath = "resources/apple_icon.png",
    double width = 16,
    double height = 16}) {
  return Image.asset(
    imagePath,
    width: width,
    height: height,
  );
}

Widget textUnderLine(String text) {
  return GestureDetector(
    onTap: () {},
    child: Text(text,
        style: TextStyle(fontSize: 12, decoration: TextDecoration.underline)),
  );
}

BoxDecoration boxDecoration() {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Colors.grey));
}

Text warningText(String text) {
  return Text(
    text,
    style: TextStyle(
      color: Colors.red
    ),
  );
}
