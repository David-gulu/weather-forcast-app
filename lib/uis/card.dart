import 'package:flutter/material.dart';
import 'package:forcaster/data/lifestyleunit.dart';

class CardBox extends StatefulWidget {

  LifeStyleUnit lifeStyleUnit;
  int index;

  @override
  CardBox({Key key, this.lifeStyleUnit, this.index}) : super(key: key);

  @override
  _CardBoxState createState() => _CardBoxState();



}

class _CardBoxState extends State<CardBox> {

  List<Color> colorList = [
    Colors.lightGreen,
    Colors.purple,
    Colors.lightBlue,
    Colors.orange,
    Colors.grey,
    Colors.brown,
    Colors.cyan,
    Colors.deepPurpleAccent,
    Colors.lightGreen[200],
    Colors.purple[200],
    Colors.lightBlue[200],
    Colors.orange[200],
    Colors.grey[200],
    Colors.brown[200],
    Colors.cyan[200],
    Colors.deepPurpleAccent[200],
  ];

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(25.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors:[colorList[widget.index], colorList[widget.index+8]]),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
              color:Colors.black54,
              offset: Offset(2.0,2.0),
              blurRadius: 4.0
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              widget.lifeStyleUnit.getType(),
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight:FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              widget.lifeStyleUnit.getBrf(),
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight:FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              widget.lifeStyleUnit.getTxt(),
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight:FontWeight.w300,
              ),
            ),
          ),



        ],
      ),
    );


  }



}
