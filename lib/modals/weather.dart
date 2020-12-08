import 'package:flutter/material.dart';

enum WeatherType{
  Rain,
  Clear,
  Clouds,
  Other
}

class Weather{
  final String id;
  final double temp;
  final double temp_min;
  final double temp_max;
  final double pressure;
  final double humidity;
  final WeatherType type;
  final String description;
  final double wind;
  final String city;
  final DateTime dateTime;

  Weather({
    @required this.id,
    @required this.temp,
    @required this.temp_min,
    @required this.temp_max,
    @required this.pressure,
    @required this.type,
    @required this.humidity,
    @required this.description,
    @required this.wind,
    @required this.city,
    @required this.dateTime,
  });
}