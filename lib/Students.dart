    import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'SelectedStudent.dart';
import 'models/Student.dart';
import 'package:http/http.dart' as http;

class Students extends StatefulWidget {
  const Students({Key? key}) : super(key: key);

  @override
  _StudentsState createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  final _auth = FirebaseAuth.instance;

  final DatabaseReference _messagesRef = FirebaseDatabase.instance.ref().child('StudentManagement/Student');
  List<Student> _studentItems = [];
  //List<Student> _studentItems = [Student(student_mobile: '0776060745', student_gender: 'male', student_name: 'Neo', student_email: 'neo@mail.com', student_id: '11')];
  late TextEditingController _ctrlId;
  late TextEditingController _ctrlName;
  late TextEditingController _ctrlGender;
  late TextEditingController _ctrlMobile;
  late TextEditingController _ctrlEmail;
  late TextEditingController _ctrlPwd;
  String img = 'assets/images/male.jpg';
  String gender='';
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ctrlId = TextEditingController();
    _ctrlName = TextEditingController();
    _ctrlGender = TextEditingController();
    _ctrlMobile = TextEditingController();
    _ctrlEmail = TextEditingController();
    _ctrlPwd = TextEditingController();

    loadData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: _studentItems.length,
            itemBuilder: (BuildContext ctx, index){
              return GestureDetector(
                //alignment: Alignment.center,
                child: Column(
                  children: [
                    Expanded(
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                            width: 200.0,
                            height: 300.0,
                            decoration: new BoxDecoration(
                              image: DecorationImage(
                                image: new AssetImage(
                                    img),
                                fit: BoxFit.contain,
                              ),
                              borderRadius:
                              BorderRadius.circular(10.0),
                            )
                        ),
                      ),
                    ),
                    SizedBox(height: 5.0,),
                    Container(
                      alignment: Alignment.center,
                      child: Text(_studentItems[index].student_name.toString()),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(15)
                      ),
                    ),
                  ],
                ),
                onTap: (){
                  var student = _studentItems[index];
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SelectedStudent(student)));
                },
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openDialog();
          _ctrlId.clear();
          _ctrlName.clear();
          _ctrlGender.clear();
          _ctrlMobile.clear();
          _ctrlEmail.clear();
        },
        tooltip: 'Add a student',
        child: Icon(Icons.add),
      ),
    );
  }


  Future openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add new Student'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(hintText: 'Enter batch ID : '),
              controller: _ctrlId,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Enter student Name : '),
              controller: _ctrlName,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Enter gender: '),
              enabled: false,
              controller: _ctrlGender,
            ),
            DropdownButton<String>(
              hint: new Text('Select gender'),
              //value: gender,
              onChanged: (selected) {
                setState(() {
                  print(selected);
                  gender = selected!;
                  _ctrlGender.text = selected;
                });
              },
              items: <String>['Male', 'Female'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Enter mobile no : '),
              controller: _ctrlMobile,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Enter email address : '),
              controller: _ctrlEmail,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Enter password : '),
              controller: _ctrlPwd,
              obscureText: true,
            ),
          ],
        ),
        actions: [ElevatedButton(onPressed: () {
          setState(() {
            _studentItems.add(Student(
                student_email: _ctrlEmail.text,
                student_id: _ctrlId.text,
                student_mobile: _ctrlMobile.text,
                student_gender: _ctrlGender.text,
                student_name: _ctrlName.text,
                student_pwd: _ctrlPwd.text
            ));
            saveStudent(_ctrlEmail.text,_ctrlId.text,_ctrlMobile.text,_ctrlGender.text,_ctrlName.text,_ctrlPwd.text);
            /*if(_ctrlGender.text == 'Male'){
              img = 'assets/images/male.jpg';
            }else{
              img = 'assets/images/female.jpg';
            }*/
            Navigator.pop(context);
          });
        }, child: Text('Save'))],
      )
  );



  void saveStudent(email, id, mobile, gender, stdName, pwd) async {

    //adding to auth

  _auth.createUserWithEmailAndPassword(email: email, password: pwd);

  final firebaseUser = (await _auth
      .createUserWithEmailAndPassword(email: email, password: pwd
  ).catchError((errorMsg){
    print('error adding use to auth ' + errorMsg);
  })).user;

  if(firebaseUser != null){
    print("========praveen======");

    // print(Course.fromMap(_courseItems));
    Map objStudent = {
      'student_batch':id,
      'student_email': email,
      'student_gender':gender,
      'student_mobile': mobile,
      'student_name': stdName,
      'student_pwd':pwd

    };

    _messagesRef.child(firebaseUser.uid).set(objStudent);
    // _messagesRef.push().set(objStudent)
    //     .then((_)=>print('student add to firebase'))
    //     .catchError((error)=> print('error adding student $error'));
  }
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
      extractedData['Student'].forEach((blogId, blogData) {
        Student student = Student(
            student_pwd: '',
            student_email: blogData["student_email"],
            student_id: blogId,
            student_gender: blogData["student_gender"],
            student_mobile: blogData["student_mobile"],
            student_name: blogData["student_name"]);
        _studentItems.add(student);
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
