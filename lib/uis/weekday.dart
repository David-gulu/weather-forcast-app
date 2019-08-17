import 'package:flutter/material.dart';
import 'package:forcaster/data/forcast.dart';

class WeekDay extends StatefulWidget {

  final WeatherForecast weatherForecast;

  Map<String, String> weekDayMap = {
    '1': '周一',
    '2': '周二',
    '3': '周三',
    '4': '周四',
    '5': '周五',
    '6': '周六',
    '7': '周日',
  };

  WeekDay({Key key, this.weatherForecast}) : super(key: key);

  @override
  _WeekDayState createState() => _WeekDayState();



}

class _WeekDayState extends State<WeekDay> {

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Container(
      padding: EdgeInsets.fromLTRB(40.0, 17.0, 40.0, 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    //widget.weatherForecast.getWeatherData1().getCurDate(),
                    widget.weekDayMap[DateTime.parse(widget.weatherForecast.getWeatherData1().getCurDate()).weekday.toString()],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                  ),
                  Image(
                    image: AssetImage('images/'+ widget.weatherForecast.getWeatherData1().getCondCode()+'.png'),
                    fit: BoxFit.fitWidth,
                    width: 40,
                    color: Colors.blue,
                  ),
                  Text(
                    widget.weatherForecast.getWeatherData1().getCondTxt(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    widget.weatherForecast.getWeatherData1().getTmpMin()+ '°C' + '~' + widget.weatherForecast.getWeatherData1().getTmpMax() + '°C',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    widget.weekDayMap[DateTime.parse(widget.weatherForecast.getWeatherData2().getCurDate()).weekday.toString()],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                  ),
                  Image(
                    image: AssetImage('images/'+ widget.weatherForecast.getWeatherData2().getCondCode()+'.png'),
                    fit: BoxFit.fitWidth,
                    width: 40,
                    color: Colors.blue,
                  ),
                  Text(
                    widget.weatherForecast.getWeatherData2().getCondTxt(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    widget.weatherForecast.getWeatherData2().getTmpMin() + '°C' + '~' + widget.weatherForecast.getWeatherData2().getTmpMax() + '°C',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    widget.weekDayMap[DateTime.parse(widget.weatherForecast.getWeatherData3().getCurDate()).weekday.toString()],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                  ),
                  Image(
                    image: AssetImage('images/'+ widget.weatherForecast.getWeatherData3().getCondCode()+'.png'),
                    fit: BoxFit.fitWidth,
                    width: 40,
                    color: Colors.blue,
                  ),
                  Text(
                    widget.weatherForecast.getWeatherData3().getCondTxt(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    widget.weatherForecast.getWeatherData3().getTmpMin() + '°C' + '~' + widget.weatherForecast.getWeatherData3().getTmpMax() + '°C',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 20),
            child: RaisedButton(
              color: Colors.lightBlue,
              highlightColor: Colors.blue[700],
              colorBrightness: Brightness.dark,
              splashColor: Colors.grey,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              padding: EdgeInsets.all(10.0),
              onPressed: () {
                Navigator.pushNamed(context, 'detail');
              },
              child: Text(
                '       点击查看舒适指数       ',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );


  }



}


