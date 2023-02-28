import 'package:flutter/material.dart';

void showNackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

String getNameFromEmail(String email) {
  //thanh0703@gmail.com
  //List [thanh0703, @gmail.com]
  //phan tu thu //0         //1
  return email.split('@')[0];
}
