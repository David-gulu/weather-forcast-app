//模型类

class WeatherData {

  String city; //城市名称
  String updateTime; //更新时间
  String cond_code; //天气图片编码
  String cond_txt; //天气状态，多云，晴等
  String hum; //湿度
  String pres; //气压
  String tmp_now; //当前温度
  String tmp_max; //最高温度
  String tmp_min; //最低温度
  String wind_dir; //风向
  String curDate; //当前年月日
  static List<String>  keys = ['d98d7718b7674091aa9d7884b18fec43',
    '163bec909e214dfea6693517f2c52877',
    'd77fe2f561f44c1b8a8d365ad503e9bf'];
  static String urlBase = 'https://free-api.heweather.net/s6/weather/';
  static String urlNow = urlBase + 'now?';
  static String urlForecast = urlBase + 'forecast?';
  static String urlLifeStyle = urlBase + 'lifestyle?';
  static String urlSearchCity = 'https://search.heweather.net/find?';


  WeatherData (String _city) {
    this.city = _city;
  }

  setNowDataFromJson (Map<String, dynamic> json) {

    //print('天气api返回：'+ json.toString());
    List <dynamic> list = json['HeWeather6'];
    //print ('list now :  '+  list.toString());
    Map <String, dynamic> info = list[0]['now'];
    //print('info now :  '+  info.toString());

    tmp_now = info['tmp'];
    cond_txt = info['cond_txt'];
    cond_code = info['cond_code'];
    wind_dir = info['wind_dir'];
    hum = info['hum'];
    pres= info['pres'];

    info = list[0]['update'];
    updateTime = info['utc'];

    print(tmp_now + ',' + cond_txt + ',' + cond_code + ',' + wind_dir + ',' + hum + ','+ pres + ',' + updateTime);


  }

  setForcastDataFromJson (Map<String, dynamic> json) {

    //print('天气api返回：'+ json.toString());
    tmp_min = json['tmp_min'];
    tmp_max = json['tmp_max'];
    cond_txt = json['cond_txt_d'];
    cond_code = json['cond_code_d'];
    curDate = json['date'];

    print (tmp_min + ',' + tmp_max + ',' + cond_txt + ',' + cond_code + ',' + curDate);


  }

  String getCity () {

    return this.city;


  }

  String getUpdateTime () {

    return this.updateTime;


  }

  String getCondCode () {

    return this.cond_code;


  }

  String getCondTxt () {

    return this.cond_txt;


  }

  String getHum () {

    return this.hum;


  }

  String getPres () {

    return this.pres;


  }

  String getTmpMin () {

    return this.tmp_min;


  }

  String getTmpMax () {

    return this.tmp_max;


  }

  String getTmpNow () {

    return this.tmp_now;


  }

  String getWindDir () {

    return this.wind_dir;


  }

  String getCurDate () {

    return this.curDate;


  }



}