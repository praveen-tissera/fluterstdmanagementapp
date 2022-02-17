import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'MyMarks.dart';
import 'models/MyCourses.dart';

class Student_Dashboard extends StatefulWidget {
  const Student_Dashboard({Key? key}) : super(key: key);

  @override
  _Student_DashboardState createState() => _Student_DashboardState();
}

class _Student_DashboardState extends State<Student_Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Manager'),
        centerTitle: true,
      ),
      drawer: new Drawer(
        child: ListView(
          children: [
            Container(
              child: UserAccountsDrawerHeader(
                accountName: Text('Student Name'),
                accountEmail: Text('Email'),
                currentAccountPicture: new CircleAvatar(
                  backgroundColor: Colors.tealAccent,
                  child: Text('Profile'),
                ),
              ),
            ),

            ListTile(
              title: Text('My Courses'),
              trailing: Icon(Icons.arrow_forward),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                        MyCourses()
                    ));
              },
            ),
            ListTile(
              title: Text('My Marks'),
              trailing: Icon(Icons.arrow_forward),
              onTap: (){
                Navigator.push(
                    context,
                    //MaterialPageRoute(builder: (context) => MembersGrid() )
                    MaterialPageRoute(builder: (context) =>
                        MyMarks()
                    ));
              },
            ),
            Divider(height: 1, color: Colors.black,),
            ListTile(
              title: Text('Exit'),
              trailing: Icon(Icons.arrow_forward),
              onTap: (){
                FirebaseAuth.instance.signOut();
                Fluttertoast.showToast(msg: "Logout Successfully");
                Navigator.pop(context);

              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          FirebaseAuth.instance.signOut();
          Fluttertoast.showToast(msg: "Logout Successfully");
          Navigator.pop(context);
          // SystemNavigator.pop();
        },
        child: Icon(Icons.close),
      ),
    );
  }
}
