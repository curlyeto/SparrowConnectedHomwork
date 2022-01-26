import 'package:flutter/material.dart';
import 'package:sparrowconnected_homework/view/costant/customtext.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final String hintText;
  const MyTextFormField({Key? key, required this.controller, required this.textInputType, required this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        decoration: InputDecoration(hintText: hintText),
        keyboardType: textInputType
    );
  }
}
