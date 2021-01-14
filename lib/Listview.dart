import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'buttons.dart';
import 'package:flutter/material.dart';
import 'qestion.dart';


List<bool> isRight = [null, null, null, null, null, null, null, null, null, null];
String jopa;

class Listofquestions extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Listofquestions> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  var dataBase = FirebaseFirestore.instance.collection("questions").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Qestions"),
      ),
      body: StreamBuilder(
        stream: dataBase,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, int index) {
                return Column(
                  children: [

                    Card(
                        child: ListTile(
                          leading: Icon(_iconButton(isRight, index)),
                          title: Text("Qestion $index"),
                          subtitle: Text(snapshot.data.docs[index]['question']),
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Question(index1: index)));
                          },
                        )
                      //[

                      //Pressedbutton(),
                      //],
                    ),
                  ],
                );
              });
        },
      ),
    );
  }

  _iconButton(List<bool> answers, int index) {
    switch (answers[index]) {
      case null:
        {
          return Icons.check_box_outline_blank_outlined;
        }
      case true:
        {
          return Icons.check;
        }
      case false:
        {
          return Icons.clear_rounded;
        }
      default:
        return Icons.check_box_outline_blank_outlined;
    }
  }
}


