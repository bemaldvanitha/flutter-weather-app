import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class CityWeather extends StatelessWidget {
  final String city;
  final double highTemp;
  final double lowTemp;
  final double temp;

  CityWeather({
    @required this.city,
    @required this.temp,
    @required this.highTemp,
    @required this.lowTemp
  });

  @override
  Widget build(BuildContext context) {
    var deviceDimention = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: deviceDimention.height * 0.03,horizontal: deviceDimention.width * 0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                  MaterialCommunityIcons.weather_hazy,
                color: Colors.orange,
                size: 50,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: deviceDimention.width * 0.02),
                child: Column(
                  children: <Widget>[
                    Text(
                        city,
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    Text(
                        (lowTemp - 273.15).round().toString() + ' / ' + (highTemp - 273.15).round().toString() + ' C ',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w200,
                        fontSize: 14
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
              (temp - 273.15).round().toString() + ' C ',
            style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 24
            ),
          )
        ],
      ),
    );
  }
}
