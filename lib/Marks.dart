import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Marks extends StatefulWidget {
  const Marks({Key? key}) : super(key: key);

  @override
  _MarksState createState() => _MarksState();
}

class _MarksState extends State<Marks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marks'),
      ),
      body: Center(

      ),
    );
  }
}
