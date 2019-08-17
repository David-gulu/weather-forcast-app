import 'package:forcaster/data/weatherdata.dart';

class WeatherForecast {

  WeatherData _weatherData1;
  WeatherData _weatherData2;
  WeatherData _weatherData3;

  WeatherForecast(String city, Map<String, dynamic> json) {

    _weatherData1 = new WeatherData(city);
    _weatherData2 = new WeatherData(city);
    _weatherData3 = new WeatherData(city);

    List <dynamic> info = json['HeWeather6'][0]['daily_forecast'];
    //info = json['daily_forecast'];
//    print ('info : ' + info.toString());

    _weatherData1.setForcastDataFromJson(info[0]);
    _weatherData2.setForcastDataFromJson(info[1]);
    _weatherData3.setForcastDataFromJson(info[2]);


  }

  WeatherData getWeatherData1 () {

    return this._weatherData1;

  }

  WeatherData getWeatherData2 () {

    return this._weatherData2;

  }

  WeatherData getWeatherData3 () {

    return this._weatherData3;

  }




}