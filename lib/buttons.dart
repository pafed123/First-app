import 'package:flutter/material.dart';
import 'dart:math';
import 'package:govno/qestion.dart';

enum Current {first,second,third,fourth}

class Pressedbuttonformultiplechoise extends StatefulWidget {
   int value;

  Pressedbuttonformultiplechoise({Key key, this.value}) : super(key: key);

  @override
  State<StatefulWidget> createState() => Changedbutton(value);
}

class Changedbutton extends State<Pressedbuttonformultiplechoise> {
  Color _iconColor = Colors.grey;
  bool f = false;
  int value1;

  Changedbutton(this.value1);
  @override
  Widget build(BuildContext) {
    return Container(
      width: 50,
      height: 50,
      child:IconButton(
          icon: Icon(Icons.where_to_vote, color: _iconColor),
          onPressed: () {

            setState(() {
              if (f == false) {
                f = true;
                _iconColor = Colors.green;
                useranswerINTcase1=useranswerINTcase1*value1;
              } else {
                f = false;
                _iconColor = Colors.grey;
                useranswerINTcase1=useranswerINTcase1~/value1;

              }
              useranswercase1=useranswerINTcase1.toString();

            });
          },
        ),
    );
  }
}


