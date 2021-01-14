import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:govno/Listview.dart';
import 'buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

int useranswerINT = 1;
String answer = "";
String useranswer = "";
String useranswercase1 = "";
int useranswerINTcase1 = 1;

bool flag = false;

class Question extends StatefulWidget {
  final int index1;
  Current _current;
  Question({Key key, this.index1}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _state(index1: index1);
}

class _state extends State<Question> {
  final int index1;
  final snackbarf = SnackBar(content: Text("Incorrect"));
  final snackbart = SnackBar(content: Text("Correct"));

  _state({Key key, this.index1});

  var dataBase = FirebaseFirestore.instance.collection("questions").snapshots();
  int useranswerINT = 1;
  String answer = "";
  String useranswer = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Qestions"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.list),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Listofquestions()));
                })
          ],
        ),
        body: StreamBuilder(
          stream: dataBase,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            useranswercase1 = "";
            useranswerINTcase1 = 1;
            answer = snapshot.data.docs[index1]['answer'];

            return ListView(
              scrollDirection: Axis.vertical,
              children: [
                Image.asset('assets/images/ITMO.jpg'),
                Container(
                  alignment: Alignment.topCenter,
                  height: 100,
                  width: 250,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 2),
                    color: Colors.amberAccent.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: Text(snapshot.data.docs[index1]['question'], style: TextStyle( fontSize: 20, fontStyle: FontStyle.italic))),
                ),
                _getanswers(snapshot, index1),
                Builder(
                  builder: (BuildContext context) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FlatButton(
                          child: Text("ANSWER"),
                          onPressed: () {
                            print("$useranswer");
                            if (snapshot.data.docs[index1]['typeofquestion'] !=
                                "1") if (useranswer == answer) {
                              print("correct");
                              setState(() {
                                isRight[index1 % snapshot.data.docs.length] =
                                    true;
                              });
                              Scaffold.of(context).showSnackBar(snackbart);
                            } else {
                              Scaffold.of(context).showSnackBar(snackbarf);
                              print("Inncorrect $useranswer     $answer  ");
                              setState(() {
                                isRight[index1 % snapshot.data.docs.length] =
                                    false;
                              });
                            }
                            else if (useranswercase1 == answer) {
                              print("correct");
                              setState(() {
                                isRight[index1 % snapshot.data.docs.length] =
                                    true;
                              });
                              Scaffold.of(context).showSnackBar(snackbart);
                            } else {
                              Scaffold.of(context).showSnackBar(snackbarf);
                              print(
                                  "Inncorrect $useranswercase1     $answer  ");
                              setState(() {
                                isRight[index1 % snapshot.data.docs.length] =
                                    false;
                              });
                            }
                          },
                        ),
                        FlatButton(
                          child: Text("Next"),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Question(
                                        index1: (index1 + 1) %
                                            snapshot.data.docs.length)));
                          },
                        ),
                      ],
                    );
                  },
                )
              ],
            );
          },
        ));
  }

  _getanswers(AsyncSnapshot<QuerySnapshot> snapshot, int index1) {
    switch (snapshot.data.docs[index1]['typeofquestion']) {
      case "1":
        return ListView.builder(
            shrinkWrap: true,
            itemCount: getAnswers(snapshot.data.docs[index1]['answers']).length,
            itemBuilder: (context, int r) {
              return Column(
                children: [
                  Card(
                    child: ListTile(
                        leading: Pressedbuttonformultiplechoise(
                            value: int.parse(getAnswers(
                                snapshot.data.docs[index1]['answersint'])[r])),
                        title: Text(
                          getAnswers(snapshot.data.docs[index1]['answers'])[r],
                          style: TextStyle(fontSize: 20, fontFamily: 'LOL'),
                        )),
                  ),
                ],
              );
            });
      case "2":
        return ListView.builder(
            shrinkWrap: true,
            itemCount: getAnswers(snapshot.data.docs[index1]['answers']).length,
            itemBuilder: (context, int r) {
              return Column(
                children: [
                  Card(
                      child: ListTile(
                    leading: Radio(
                      value: Current.values[r],
                      groupValue: widget._current,
                      onChanged: (Current newValue) {
                        setState(() {
                          widget._current = newValue;
                          useranswer = widget._current.toString().toLowerCase();
                        });
                        print("$useranswer");
                      },
                    ),
                    title: Text(
                        getAnswers(snapshot.data.docs[index1]['answers'])[r],style: TextStyle( fontSize: 30,  fontFamily: 'RRR')),
                  )),
                ],
              );
            });
      case "3":
        return ListView.builder(
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder: (context, int r) {
              return Column(
                children: [
                  Card(
                      child: ListTile(
                    leading: Radio(
                      value: Current.values[r],
                      groupValue: widget._current,
                      onChanged: (Current newValue) {
                        setState(() {
                          widget._current = newValue;
                          useranswer = widget._current.toString().toLowerCase();
                        });
                        print("$useranswer");
                      },
                    ),
                    title: Text(
                        getAnswers(snapshot.data.docs[index1]['answers'])[r], style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic)),
                  )),
                ],
              );
            });
      case "4":
        {
          return Container(
            child: Column(children: [
              TextField(
                  decoration: InputDecoration(
                    hintText: "Enter your answer",
                    contentPadding: EdgeInsets.all(8),
                  ),
                  onChanged: (value) {
                    setState(() {
                      useranswer = value;
                    });
                  }),
              Container(
                height: 120,
              )
            ]),
            margin: EdgeInsets.all(10),
          );
        }
    }
  }
}

List<String> getAnswers(String str) {
  List<String> answers = [];
  String ans = "";
  for (int i = 0; i < str.length; i++) {
    if (str[i] != ';')
      ans = ans + str[i];
    else {
      answers.add(ans);
      ans = "";
    }
    ;
  }
  return answers;
}
