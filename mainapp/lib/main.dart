import 'package:flutter/material.dart';

import 'logic.dart';

void main() {
  runApp(myApp());
}

class myApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: xoapp(),
    );
  }
}