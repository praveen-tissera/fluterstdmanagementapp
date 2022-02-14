import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Batches.dart';
import 'models/Course.dart';


class Courses extends StatefulWidget {
  const Courses({Key? key}) : super(key: key);

  @override
  _CoursesState createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {

  List<Course> _courseItems = [];
  late TextEditingController _ctrlId;
  late TextEditingController _ctrlName;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ctrlId = TextEditingController();
    _ctrlName = TextEditingController();

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Courses'),
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: _courseItems.length,
          itemBuilder: (context, index) {
            return ListTile(
                leading: Icon(Icons.list),
                trailing: Container(
                    child: IconButton(icon: Icon(Icons.border_color ) , onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: Text("Edit Course"), duration: Duration(milliseconds: 300), ), );
                    },)),
                title: Text(_courseItems[index].course_name.toString()),
              subtitle: Text(_courseItems[index].course_id.toString()) ,
              onTap: () {
                //Navigator.of(context).push(MaterialPageRoute(builder: (context) => Batches()));
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _ctrlId.clear();
          _ctrlName.clear();
          openDialog();

          //addData('Test my code');
        },
        tooltip: 'Add a batch',
        child: Icon(Icons.add),
      ),
    );
  }

  Future openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add new course'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(hintText: 'Enter Course ID : '),
              controller: _ctrlId,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Enter Course Name : '),
              controller: _ctrlName,
            ),
          ],
        ),
        actions: [ElevatedButton(onPressed: () {
          setState(() {
            //_courseItems.add(Course(course_id: _ctrlId.text , course_name: _ctrlName.text));
            Navigator.pop(context);
          });
        }, child: Text('Save'))],
      )
  );

  void loadData() async {
    var url = "https://my-projects-e5de2-default-rtdb.firebaseio.com/" +
        "StudentManagement.json";
    // Do not remove “data.json”,keep it as it is
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      extractedData['Courses'].forEach((blogId, blogData) {
        Course course = Course(
            course_id: blogData["Course_ID"],
            course_name: blogData["Course_Name"]);
        _courseItems.add(course);
      });

      setState(() {
        isLoading = false;
      });
    } catch (error) {
      print(error.toString());
      //throw error;
    }
  }
}
