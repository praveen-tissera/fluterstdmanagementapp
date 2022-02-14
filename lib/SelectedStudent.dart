import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/Student.dart';

class SelectedStudent extends StatefulWidget {
  Student student;

  SelectedStudent(this.student,{Key? key}) : super(key: key);

  @override
  _SelectedStudentState createState() => _SelectedStudentState();
}

class _SelectedStudentState extends State<SelectedStudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.student.student_name}'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${widget.student.student_id}', style: TextStyle(fontSize: 20.0),),
            SizedBox(height: 10.0,),
            Text('${widget.student.student_mobile}', style: TextStyle(fontSize: 20.0),),
            SizedBox(height: 10.0,),
            Text('${widget.student.student_email}', style: TextStyle(fontSize: 15.0),),
            SizedBox(height: 10.0,),
            Text('${widget.student.student_gender}', style: TextStyle(fontSize: 15.0),),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: Text("Edit Student"), duration: Duration(milliseconds: 300), ), );
        },
        tooltip: 'Edit student',
        child: Icon(Icons.border_color ),
      ),
    );
  }
}
