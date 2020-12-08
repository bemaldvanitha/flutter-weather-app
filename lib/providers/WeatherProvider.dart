import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../modals/weather.dart';

class WeatherProvider with ChangeNotifier{
  List<Weather> _currentWeatherList = [
    /*Weather(
      id: 'w1',
      temp: 297.91,
      temp_max: 297.91,
      temp_min: 297.74,
      humidity: 88,
      pressure: 1010,
      type: WeatherType.Clouds,
      wind: 2.61,
      description: 'broken clouds',
      dateTime: DateTime.now(),
      city: 'Matara'
    ),
    Weather(
        id: 'w2',
        temp: 301.13,
        temp_max: 301.97,
        temp_min: 301.13,
        humidity: 72,
        pressure: 1012,
        type: WeatherType.Clouds,
        wind: 1.91,
        description: 'broken clouds',
        dateTime: DateTime.now().add(Duration(hours: 3)),
        city: 'Matara'
    ),
    Weather(
        id: 'w3',
        temp: 303.29,
        temp_max: 303.65,
        temp_min: 303.29,
        humidity: 62,
        pressure: 1012,
        type: WeatherType.Clouds,
        wind: 2.45,
        description: 'broken clouds',
        dateTime: DateTime.now().add(Duration(hours: 6)),
        city: 'Matara'
    ),
    Weather(
        id: 'w4',
        temp: 303.09,
        temp_max: 303.13,
        temp_min: 303.09,
        humidity: 65,
        pressure: 1009,
        type: WeatherType.Clouds,
        wind: 3.45,
        description: 'scattered clouds',
        dateTime: DateTime.now().add(Duration(hours: 9)),
        city: 'Matara'
    ),
    Weather(
        id: 'w5',
        temp: 301.17,
        temp_max: 301.17,
        temp_min: 301.17,
        humidity: 73,
        pressure: 1009,
        type: WeatherType.Clouds,
        wind: 2.52,
        description: 'scattered clouds',
        dateTime: DateTime.now().add(Duration(hours: 12)),
        city: 'Matara'
    ),
    Weather(
        id: 'w6',
        temp: 299.64,
        temp_max: 299.64,
        temp_min: 299.64,
        humidity: 80,
        pressure: 1012,
        type: WeatherType.Clouds,
        wind: 1.78,
        description: 'scattered clouds',
        dateTime: DateTime.now().add(Duration(hours: 15)),
        city: 'Matara'
    ),
    Weather(
        id: 'w7',
        temp: 281.97,
        temp_max: 282.21,
        temp_min: 281.97,
        humidity: 59,
        pressure: 1017,
        type: WeatherType.Clear,
        wind: 3.48,
        description: 'clear sky',
        dateTime: DateTime.now().add(Duration(hours: 18)),
        city: 'Matara'
    ),
    Weather(
        id: 'w8',
        temp: 282.31,
        temp_max: 282.39,
        temp_min: 282.31,
        humidity: 68,
        pressure: 1015,
        type: WeatherType.Rain,
        wind: 4.09,
        description: 'light rain',
        dateTime: DateTime.now().add(Duration(hours: 21)),
        city: 'Matara'
    ),*/
  ];

  List<String> _cityList = [];

  String _currentCity = 'Current City';

  List<Weather> get currentWeather{
    return [..._currentWeatherList];
  }

  List<Weather> get differentWeather{
    final List<Weather> _cityViseWeather = [];

    _cityList.forEach((city) {
      var weather = _currentWeatherList.firstWhere((weath) => weath.city == city);
        _cityViseWeather.add(weather);
    });

    return [..._cityViseWeather];
  }

  String get currentCity{
    return _currentCity;
  }

  Future<void> fetchWeatherByPosition(double latitude,double longitude) async {
    final url = 'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=823197b6a9055932ede9d2a3903fa295';

    try{
      final response = await http.get(url);
      final resData = json.decode(response.body);
      final List<Weather> newWeather = [];

      if(resData['cod'] == "200"){
        final resList = resData['list'] as List<dynamic>;
        final cityName = resData['city']['name'];

        resList.sublist(0,7).forEach((data) {
          WeatherType weatherType;

          if(data['weather'][0]['main'] == 'Rain'){
            weatherType = WeatherType.Rain;
          }else if(data['weather'][0]['main'] == 'Clouds'){
            weatherType = WeatherType.Clouds;
          }else if(data['weather'][0]['main'] == 'Clear'){
            weatherType = WeatherType.Clear;
          }else{
            weatherType = WeatherType.Other;
          }

          Weather weatherItem = Weather(
            id: DateTime.now().toString(),
            temp: double.parse(data['main']['temp'].toString()),
            temp_min: double.parse(data['main']['temp_min'].toString()),
            temp_max: double.parse(data['main']['temp_max'].toString()),
            humidity: double.parse(data['main']['humidity'].toString()),
            description: data['weather'][0]['description'],
            pressure: double.parse(data['main']['pressure'].toString()),
            wind: double.parse(data['wind']['speed'].toString()),
            dateTime: DateTime.parse(data['dt_txt']),
            city: cityName,
            type: weatherType,
          );

          newWeather.add(weatherItem);

        });
          _currentCity = cityName;
          _cityList.add(cityName);

          _currentWeatherList = newWeather;
          notifyListeners();
      }
    }catch(err){
      throw err;
    }
  }



  Future<void> addCity(String city) async {
    final url = 'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=823197b6a9055932ede9d2a3903fa295';
    try{
      final response = await http.get(url);
      final resData = json.decode(response.body);
      //final List<Weather> weatherList = [];

      if(resData['cod'] == '200'){
        final resList = resData['list'] as List<dynamic>;
        final cityName = resData['city']['name'];

        resList.forEach((data) {
          WeatherType weatherType;

          if(data['weather'][0]['main'] == 'Clear'){
            weatherType = WeatherType.Clear;
          }else if(data['weather'][0]['main'] == 'Rain'){
            weatherType = WeatherType.Rain;
          }else if(data['weather'][0]['main'] == 'Clouds'){
            weatherType = WeatherType.Clouds;
          }else{
            weatherType = WeatherType.Other;
          }

          Weather weather = Weather(
            id: DateTime.now().toString(),
            temp: double.parse(data['main']['temp'].toString()),
            temp_min: double.parse(data['main']['temp_min'].toString()),
            temp_max: double.parse(data['main']['temp_max'].toString()),
            pressure: double.parse(data['main']['pressure'].toString()),
            humidity: double.parse(data['main']['humidity'].toString()),
            dateTime: DateTime.parse(data['dt_txt']),
            wind: double.parse(data['wind']['speed'].toString()),
            description: data['weather'][0]['description'],
            city: cityName,
            type: weatherType,
          );

          // weatherList.add(weather);
          _currentWeatherList.add(weather);
        });
        _cityList.add(cityName);

        notifyListeners();
      } else {
        throw HttpException('city not found');
      }
    }catch(err){
      throw err;
    }
  }

}