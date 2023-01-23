import 'package:flutter/material.dart';

Widget myTextField(String hintText,keyBoardType,controller){
  return TextField(
    keyboardType: keyBoardType,
    controller: controller,

    decoration: InputDecoration(
      border: OutlineInputBorder(),
      hintStyle:TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        color:Colors.black,
        fontSize: 15,
      ),
      hintText: hintText,
    ),
  );
}