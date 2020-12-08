import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../modals/weather.dart';

class WeatherTile extends StatelessWidget {
  final WeatherType weatherType;
  final String detail;
  final double max_temp;
  final double min_temp;
  final DateTime dateTime;
  final String id;

  WeatherTile({
    @required this.weatherType,
    @required this.detail,
    @required this.max_temp,
    @required this.min_temp,
    @required this.dateTime,
    @required this.id,
  });

  @override
  Widget build(BuildContext context) {
    var _icon;
    Color color;
    Color color2;

    if(weatherType == WeatherType.Clouds){
      _icon = MaterialCommunityIcons.weather_cloudy;
      color = Colors.grey;
      color2 = Colors.black12;
    }else if(weatherType == WeatherType.Clear){
      _icon = MaterialCommunityIcons.weather_sunny;
      color = Colors.blue;
      color2 = Colors.lightBlueAccent;
    }else if(weatherType == WeatherType.Rain){
      _icon = MaterialCommunityIcons.weather_rainy;
      color = Colors.blueAccent;
      color2 = Colors.blue;
    }else{
      _icon = MaterialCommunityIcons.weather_night;
      color = Colors.black.withOpacity(0.8);
      color2 = Colors.black.withOpacity(0.4);
    }

    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed('/weatherDetail',arguments: id);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
        margin: EdgeInsets.symmetric(vertical: 2,horizontal: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color,
              color2
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            tileMode: TileMode.clamp
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Icon(
              _icon,
              size: 30,
              color: Colors.red,
            ),
            Text(
                dateTime.toString().substring(0,13),
              style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
              softWrap: true,
            ),
            Text(
                (min_temp - 273.15).round().toString() + '/'+ (max_temp - 273.15).round().toString() + ' C',
              style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
              softWrap: true,
            )
          ],
        ),
      ),
    );
  }
}
