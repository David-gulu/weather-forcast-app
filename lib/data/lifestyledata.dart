import 'package:forcaster/data/lifestyleunit.dart';

//模型类

class LifeStyleData {

  String city; //城市名称
  List<LifeStyleUnit> styleData = new List<LifeStyleUnit>();
  Map<String, String> typeMap = {

    'comf' : '舒适度指数',
    'drsg' : '穿衣指数',
    'flu' : '感冒指数',
    'sport' : '运动指数',
    'trav' : '旅游指数',
    'uv' : '紫外线指数',
    'cw' : '洗车指数',
    'air' : '空气污染扩散指数',

  };
  static List<String>  keys = ['d98d7718b7674091aa9d7884b18fec43',
    '163bec909e214dfea6693517f2c52877',
    'd77fe2f561f44c1b8a8d365ad503e9bf'];
  static String urlBase = 'https://free-api.heweather.net/s6/weather/';
  static String urlLifestyle = urlBase + 'lifestyle?';


  LifeStyleData (String _city, Map<String, dynamic> json) {

    this.city = _city;
    setLifeStyleDataFromJson(json);


  }

  setLifeStyleDataFromJson (Map<String, dynamic> json) {

    //print('天气api返回：'+ json.toString());
    List <dynamic> list = json['HeWeather6'];
    //print ('list now :  '+  list.toString());
    list = list[0]['lifestyle'];
    //print('info now :  '+  list.toString());
    
    for (int i=0; i< list.length; i++) {

      Map<String, dynamic> map = list[i];
      //print('map now :  '+  map.toString());
      //print(map['txt']);
      //LifeStyleUnit('test' ,'test', 'test');
      //LifeStyleUnit(typeMap[map['type']].toString(), map['brf'].toString(), map['txt'].toString());
      styleData.add(LifeStyleUnit(typeMap[map['type']], map['brf'], map['txt']));

    }



  }


  List<LifeStyleUnit> getStyleData () {

    return this.styleData;


  }



}