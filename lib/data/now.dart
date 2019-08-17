import 'package:forcaster/data/weatherdata.dart';

class WeatherNow {

  WeatherData weatherData;

  WeatherNow(String city, Map<String, dynamic> json) {

    weatherData = new WeatherData(city);
    weatherData.setNowDataFromJson(json);


  }

  WeatherData getWeatherData () {
    return this.weatherData;
  }



}