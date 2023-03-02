import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget button({onpress, color, textcolor, String? title, isloading}) {
  isloading = isloading;
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: color,
      padding: EdgeInsets.all(12),
    ),
    onPressed: onpress,
    child: title!.text
        .color(textcolor)
        .fontWeight(FontWeight.bold)
        .size(100)
        .make(),
  ).box.size(250, 50).make();
}
