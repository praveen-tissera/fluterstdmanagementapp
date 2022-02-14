import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Batches.dart';
import 'Courses.dart';
import 'Marks.dart';
import 'Students.dart';

class Admin_Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Admin_Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Panel"),
        elevation: .1,
        backgroundColor: Color.fromRGBO(49, 87, 110, 1.0),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(3.0),
          children: <Widget>[
            makeDashboardItem("Courses", Icons.card_travel ),
            makeDashboardItem("Batches", Icons.theater_comedy_outlined ),
            makeDashboardItem("Students", Icons.supervised_user_circle ),
            makeDashboardItem("Marks", Icons.table_view_rounded )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          SystemNavigator.pop();
        },
        tooltip: 'Exit',
        child: Icon(Icons.superscript_rounded ),
      ),
    );
  }

  Card makeDashboardItem(String title, IconData icon) {
    return Card(
        elevation: 1.0,
        margin: new EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
          child: new InkWell(
            onTap: () {
              switch (title) {
                case 'Courses':
                  //ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: Text("Courses"), duration: Duration(milliseconds: 300), ), );
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Courses()));
                  break;
                case 'Batches':
                  //ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: Text("Batches"), duration: Duration(milliseconds: 300), ), );
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Batches()));
                  break;
                case 'Students':
                  //ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: Text("Students"), duration: Duration(milliseconds: 300), ), );
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Students()));
                  break;
                case 'Marks':
                  //ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: Text("Marks"), duration: Duration(milliseconds: 300), ), );
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Marks()));
                  break;
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 50.0),
                Center(
                    child: Icon(
                      icon,
                      size: 40.0,
                      color: Colors.black,
                    )),
                SizedBox(height: 20.0),
                new Center(
                  child: new Text(title,
                      style:
                      new TextStyle(fontSize: 18.0, color: Colors.black)),
                )
              ],
            ),
          ),
        ));
  }
}