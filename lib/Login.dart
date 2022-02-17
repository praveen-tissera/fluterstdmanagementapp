import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentmanagement/Student_Dashboard.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Admin_Dashboard.dart';
import 'Courses.dart';

class Login extends StatefulWidget {

  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<Login> {
  TextEditingController _ctrlEmail = new TextEditingController();
  TextEditingController _ctrlPassword = new TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Master Login"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Center(
                child: Container(
                    width: 300,
                    height: 400,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('assets/images/login.jpg')),
              ),
            ),
            SizedBox(height: 20.0,),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com'),
                controller: _ctrlEmail,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(

                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
                controller: _ctrlPassword,
              ),
            ),
            /*FlatButton(
              onPressed: (){
                //TODO FORGOT PASSWORD SCREEN GOES HERE
              },
              child: Text(
                'Forgot Password',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),*/
            SizedBox(height: 20.0,),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                onPressed: () async {
                  try {
                  final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: _ctrlEmail.text, password: _ctrlPassword.text
                  );

                    if (user != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => Admin_Dashboard()));

                    }else{
                      Fluttertoast.showToast(msg: "Invalid email or password.");

                    }
                  }
                  catch(e){
                    Fluttertoast.showToast(msg: "Invalid email or password.");
                    print(e);
                    // Fluttertoast.showToast(msg: "Invalid email or password.");
                  }

                },
                child: Text(
                  'Admin Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: _ctrlEmail.text, password: _ctrlPassword.text
                    );

                    if (user != null) {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => Student_Dashboard()));
                    }else{
                      Fluttertoast.showToast(msg: "Invalid email or password.");

                    }
                  }
                  catch(e){
                    Fluttertoast.showToast(msg: "Invalid email or password.");
                    print(e);
                    // Fluttertoast.showToast(msg: "Invalid email or password.");
                  }

                },

                child: Text(
                  'Student',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            //Text('New User? Create Account')
          ],
        ),
      ),
    );
  }
}

