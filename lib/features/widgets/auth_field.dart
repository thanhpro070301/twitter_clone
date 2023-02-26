// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/pallete.dart';

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  String hinText;
  AuthField({super.key, required this.controller, required this.hinText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Palette.blueColor, width: 2),
          ),
          hintText: hinText,
          hintStyle: const TextStyle(fontSize: 19),
          contentPadding: const EdgeInsets.all(22),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Palette.blueColor, width: 2),
          )),
    );
  }
}
