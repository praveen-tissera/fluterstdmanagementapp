      import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Students.dart';
import 'models/Batch.dart';

class Batches extends StatefulWidget {
  const Batches({Key? key}) : super(key: key);

  @override
  _BatchesState createState() => _BatchesState();
}

class _BatchesState extends State<Batches> {
  final DatabaseReference _messagesRef = FirebaseDatabase.instance.ref().child('StudentManagement/Batches');

  List<Batch> _batchItems = [];
  late TextEditingController _ctrlId;
  late TextEditingController _ctrlName;
  late TextEditingController _ctrlDate;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ctrlId = TextEditingController();
    _ctrlName = TextEditingController();
    _ctrlDate = TextEditingController();

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Batches'),
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: _batchItems.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(Icons.list),
              trailing: Container(
                  child: IconButton(icon: Icon(Icons.border_color ) , onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: Text("Edit Batch"), duration: Duration(milliseconds: 300), ), );
                  },)),
              title: Text(_batchItems[index].batch_name.toString()),
              subtitle: Text(_batchItems[index].batch_st_date.toString()) ,
              onTap: () {
                //Navigator.of(context).push(MaterialPageRoute(builder: (context) => Students()));
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _ctrlId.clear();
          _ctrlName.clear();
          _ctrlDate.clear();
          openDialog();
        },
        tooltip: 'Add a batch',
        child: Icon(Icons.add),
      ),
    );
  }

  Future openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add new batch'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(hintText: 'Enter batch ID : '),
              controller: _ctrlId,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Enter batch Name : '),
              controller: _ctrlName,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Enter batch Starting Date : '),
              controller: _ctrlDate,
            ),
          ],
        ),
        actions: [ElevatedButton(onPressed: () {
          setState(() {
            _batchItems.add(Batch(batch_id: _ctrlId.text , batch_name : _ctrlName.text, batch_st_date: _ctrlDate.text));
            saveBatches(_ctrlId.text,_ctrlName.text,_ctrlDate.text);
            Navigator.pop(context);
          });
        }, child: Text('Save'))],
      )
  );

  void saveBatches(id, title,day) async {
    print("========praveen======");
    // print(Course.fromMap(_courseItems));
    final objBatch = <String, dynamic> {
      'batch_name':title,
      'batch_st_date': day,
      'course_id': id,
    };
    // print(_courseItems);
    _messagesRef.push().set(objBatch)
        .then((_)=>print('course add to firebase praveen'))
        .catchError((error)=> print('error praveen $error'));
  }
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
      extractedData['Batches'].forEach((blogId, blogData) {
        Batch batch = Batch(
            batch_id: blogData["batch_id"],
            batch_name: blogData["batch_name"],
            batch_st_date: blogData["batch_st_date"],
            );
        _batchItems.add(batch);
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
