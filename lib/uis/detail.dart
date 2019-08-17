import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:forcaster/data/lifestyledata.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:forcaster/data/weatherdata.dart';
import 'package:forcaster/uis/card.dart';

class DetailPage extends StatefulWidget {

  @override
  _DetailPageState createState() => _DetailPageState();



}

class _DetailPageState extends State<DetailPage> {

  String _city;
  LifeStyleData lifeStyleData;
  Map<String, dynamic> _jsonLifeStyle;
  Response response = new Response();
  Dio dio = Dio();

  Future<String> _readCity () async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String loc = sharedPreferences.getString('curCity');
    if (loc == null) {

      loc = '北京';
      sharedPreferences.setString('curCity', '北京');
      return loc;

    }
    return loc;


  }

  Future<Map<String, dynamic>> _getJson(String city, String url) async {

    //print(url);
    response = await dio.get(url);
    //print(response.data);
    //print ('response body : '+ response.data.toString());
    //return json.decode(response.data);
    return response.data;

  }

  @override
  void initState() {

    super.initState();
    _readCity().then((String _loc){

      _city = _loc;
     print("city: "+ _city);

    }).then((_) async {
      String urlLifeStyle = WeatherData.urlLifeStyle+ 'location=' + _city + '&key=' + WeatherData.keys[0] ;
      //print ('urllifestyle: ' + urlLifeStyle);
      _jsonLifeStyle = await _getJson(_city, urlLifeStyle);
    }).then((_) {
      setState(() {
        lifeStyleData = new LifeStyleData(_city, _jsonLifeStyle);
      });
    });


  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(right: 230),
              title: Padding(
                padding: EdgeInsets.only(bottom: 10,),
                child: Text(
                  '生活指数',
                  style: TextStyle(
                    fontSize: 23,
                  ),
                ),
              ),
              background: Image.asset('images/lifeindex.jpg',fit: BoxFit.cover),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(25.0),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
//                  return Container(
//                    alignment: Alignment.center,
//                    color: Colors.lightGreen[100 * ((index+1) % 9)],
//                    child:
//                      Text('grid item $index'),
//                      //Card(lifeStyleData[index]),
//                  );
                    return CardBox(lifeStyleUnit: lifeStyleData.getStyleData()[index], index: index);
                  },
                childCount: 8,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 30.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 2,
              ),
            ),

          )

        ],
      ),



//      appBar: AppBar(
//        title: Text('生活指数'),
//      ),
//      body: Container(
//      ),
    );


  }



}