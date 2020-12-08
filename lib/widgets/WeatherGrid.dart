import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../widgets/weatherBox.dart';

class WeatherGrid extends StatelessWidget {
  final double windSpeed;
  final double humidity;
  final double presure;
  final double temp;

  WeatherGrid({
    @required this.humidity,
    @required this.temp,
    @required this.presure,
    @required this.windSpeed
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text('Weather Detail'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              WeatherBox(
                icon: MaterialCommunityIcons.weather_windy,
                value: windSpeed,
                name: 'wind',
                unit: 'km/h',
              ),
              WeatherBox(
                icon: MaterialCommunityIcons.water_percent,
                unit: '%',
                name: 'humidity',
                value: humidity,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              WeatherBox(
                value: (temp - 273).round().toDouble(),
                name: 'temp',
                unit: ' c',
                icon: MaterialCommunityIcons.thermometer,
              ),
              WeatherBox(
                icon: MaterialCommunityIcons.speedometer,
                unit: 'bar',
                name: 'pressure',
                value: presure,
              )
            ],
          ),
        ],
      ),
    );
  }
}
