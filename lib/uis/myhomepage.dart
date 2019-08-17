import 'package:forcaster/uis/box.dart';
import 'package:flutter/material.dart';
import 'package:forcaster/uis/weekday.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:forcaster/data/forcast.dart';
import 'package:forcaster/data/now.dart';
import 'package:dio/dio.dart';
import 'package:forcaster/data/weatherdata.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:forcaster/blocs/bloc_provider.dart';
import 'package:forcaster/blocs/city_bloc.dart';


class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();



}

class _MyHomePageState extends State<MyHomePage> {

  String cityName;

  WeatherNow _weatherNow;
  Response response = new Response();
  Dio dio = Dio();
  WeatherForecast _weatherForecast;
  Map<String, dynamic> _jsonNow;
  Map<String, dynamic> _jsonForecast;


  Future<String> _readCity () async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//    await sharedPreferences.setString('curCity', '北京');
    String loc = sharedPreferences.getString('curCity');
    if (loc == null) {

      loc = '北京';
      sharedPreferences.setString('curCity', '北京');
      return loc;

    }
    return loc;


  }

  Future _setCity (String _city) async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//    await sharedPreferences.setString('curCity', '北京');
    sharedPreferences.setString('curCity', _city);


  }


  Future<Map<String, dynamic>> _getJson(String city, String url) async {

    //print(url);
    response = await dio.get(url);
    //print(response.data);
    //print ('response body : '+ response.data.toString());
    //return json.decode(response.data);
    return response.data;

  }

  RefreshController _refreshController = RefreshController(initialRefresh: true);


  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
//    Fluttertoast.showToast(
//      msg: '刷新中',
//      toastLength: Toast.LENGTH_SHORT,
//      gravity: ToastGravity.CENTER,
//      timeInSecForIos: 1,
//    );
    _readCity().then((String _loc){

      cityName = _loc;
      print("city: "+ cityName);

    }).then((_) async {
      String urlNow = WeatherData.urlNow + 'location=' + cityName + '&key=' + WeatherData.keys[0] ;
      _jsonNow = await _getJson(cityName, urlNow);
    }).then((_) async {
      String urlForecast = WeatherData.urlForecast + 'location=' + cityName + '&key=' + WeatherData.keys[0] ;
      _jsonForecast = await _getJson(cityName, urlForecast);
    }).then((_) {
      setState(() {
        _weatherNow = new WeatherNow(cityName, _jsonNow);
        _weatherForecast = new WeatherForecast(cityName, _jsonForecast);
      });
    });

    _refreshController.refreshCompleted();


  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
//    items.add((items.length+1).toString());
    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();


  }


//控件smartrefresher在页面启动前，首先会执行onrefresh, 所以不需要重写init方法了，故注释掉

//  @override
//  void initState() {
//
//    super.initState();
//     _readCity().then((String _loc){
//
//      _city = _loc;
//      print("city: "+ _city);
//
//    }).then((_) async {
//      String urlNow = WeatherData.urlNow + 'location=' + _city + '&key=' + WeatherData.keys[0] ;
//      _jsonNow = await _getJson(_city, urlNow);
//    }).then((_) async {
//      String urlForecast = WeatherData.urlForecast + 'location=' + _city + '&key=' + WeatherData.keys[0] ;
//      _jsonForecast = await _getJson(_city, urlForecast);
//    }).then((_) {
//      setState(() {
//        _weatherNow = new WeatherNow(_city, _jsonNow);
//        _weatherForecast = new WeatherForecast(_city, _jsonForecast);
//      });
//    });
//
//
//  }


  @override
  Widget build(BuildContext context) {

    CityBloc cityBloc = BlocProvider.of<CityBloc>(context);
    //cityBloc.switchCity('武汉');

    cityBloc.cityStream.listen((_cityToSwitch) {

      cityName = _cityToSwitch;
      _setCity(_cityToSwitch).then((_) async {
        String urlNow = WeatherData.urlNow + 'location=' + cityName + '&key=' + WeatherData.keys[0] ;
        _jsonNow = await _getJson(cityName, urlNow);
      }).then((_) async {
        String urlForecast = WeatherData.urlForecast + 'location=' + cityName + '&key=' + WeatherData.keys[0] ;
        _jsonForecast = await _getJson(cityName, urlForecast);
      }).then((_) {
        setState(() {
          _weatherNow = new WeatherNow(cityName, _jsonNow);
          _weatherForecast = new WeatherForecast(cityName, _jsonForecast);
        });
      });

    });

    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context,LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("pull up load");
            }
            else if (mode == LoadStatus.loading) {
              body =  Text("Load Failed!Click retry!");
            }
            else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            }
            else {
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:
                  Box(weatherNow: _weatherNow,),
                  flex: 8,
                ),
                Expanded(
                  child:
                  WeekDay(weatherForecast: _weatherForecast,),
                  flex: 3,
                ),
              ],
            )
        ),
      ),
    );
  }

  @override void dispose() {
    // TODO: implement dispose
    super.dispose();
    _refreshController.dispose();


  }


}