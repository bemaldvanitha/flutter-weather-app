import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../modals/weather.dart';

class WeatherData extends StatelessWidget {
  final bool isSpecial;
  final String id;
  final WeatherType type;
  final DateTime dateTime;
  final double temp;
  final double humidity;
  final String detail;

  WeatherData({
    @required this.id,
    @required this.dateTime,
    @required this.type,
    @required this.isSpecial,
    @required this.temp,
    @required this.humidity,
    @required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    var _selIcon;

    if(type == WeatherType.Rain){
      _selIcon = MaterialCommunityIcons.weather_rainy;
    }else if(type == WeatherType.Clouds){
      _selIcon = MaterialCommunityIcons.weather_cloudy;
    }else if(type == WeatherType.Clear){
      _selIcon = MaterialCommunityIcons.weather_sunny;
    }else{
      _selIcon = MaterialCommunityIcons.weather_hazy;
    }

    return Container(
      decoration: BoxDecoration(
        color: isSpecial ? Colors.black26 : Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: EdgeInsets.symmetric(vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.25,vertical: 20),
      child: Column(
        children: <Widget>[
          Text(
              dateTime.toString().substring(5,16),
            style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 16,
            ),
          ),
          Icon(
              _selIcon,
              size: 50,
              color: Colors.redAccent,
          ),
          Text(
              detail,
              style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 16
              ),
          ),
          Text(
              (temp - 273.15).roundToDouble().toString() + ' C ',
            style: TextStyle(
              fontFamily: 'Raleway',
              fontStyle: FontStyle.italic,
              fontSize: 14,
            ),
          ),
          Text(
              humidity.toString() + ' % ',
            style: TextStyle(
              fontFamily: 'Raleway',
              fontStyle: FontStyle.italic,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
