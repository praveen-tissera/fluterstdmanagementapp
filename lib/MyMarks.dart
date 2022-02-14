import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyMarks extends StatefulWidget {
  const MyMarks({Key? key}) : super(key: key);

  @override
  _MyMarksState createState() => _MyMarksState();
}

class _MyMarksState extends State<MyMarks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Marks'),
        centerTitle: true,
      ),
    );
  }
}
