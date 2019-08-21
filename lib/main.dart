import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String myText = null;
  final DocumentReference documentReference =
      Firestore.instance.document("myData/dummy");
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _add() {
    Map<String, String> data = <String, String>{
      "name": "Nikhil Chaudhary",
      "desc": "Flutter Developer"
    };
    documentReference.setData(data).whenComplete(() {
      print("Document Added");
    }).catchError((e) => print(e));
  }

  void _delete() {
    documentReference.delete().whenComplete(() {
      print("Delated Sucefully");
      setState(() {});
    }).catchError((e) => print(e));
  }

  void _update() {
    Map<String, String> data = <String, String>{
      "name": "Nikhil Chaudhary Updated",
      "desc": "Flutter Developer Updated"
    };
    documentReference.updateData(data).whenComplete(() {
      print("Document Updated");
    }).catchError((e) => print(e));
  }

  void _fetch() {
    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          myText = datasnapshot.data['name'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Data",
      theme: ThemeData(brightness: Brightness.dark),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Welcome to Rhesustech"),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 80,
                  ),
                  Text(
                    "Hello World",
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Database integrations",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(height: 10,),
                  RaisedButton(
                    onPressed: () => _add(),
                    child: Text("Add"),
                    color: Colors.blue,
                  ),
                  RaisedButton(
                    onPressed: () => _update(),
                    child: Text("Update"),
                    color: Colors.orange,
                  ),
                  RaisedButton(
                    onPressed: () => _delete(),
                    child: Text("Dalete"),
                    color: Colors.lime,
                  ),
                  RaisedButton(
                    onPressed: () => _fetch(),
                    child: Text("Fetch"),
                    color: Colors.pink,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  myText == null
                      ? new Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Step For Fetching Data :"),
                            SizedBox(height: 15,),
                            Text("Step: 1: Click On Add Button"),
                            Text("Step: 2: Click On Fetch Button"),
                            Text("Step: 3: Click On Update Button"),
                            Text("Step: 4: Click On Fetch Button for updated data"),
                          ],
                        ),
                      )
                      : new Text(
                          myText,
                          style: TextStyle(fontSize: 25),
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
