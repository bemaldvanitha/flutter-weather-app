import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/WeatherProvider.dart';
import '../widgets/WeatherData.dart';

class WeatherDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final selectedWeather = ModalRoute.of(context).settings.arguments as String;
    final weatherData = Provider.of<WeatherProvider>(context).currentWeather;

    print(selectedWeather);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Weather Detail'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.orange[100],
              Colors.orangeAccent[100]
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          )
        ),
        child: ListView.builder(
            itemBuilder: (ctx,index){
              return WeatherData(
                id: weatherData[index].id,
                type: weatherData[index].type,
                dateTime: weatherData[index].dateTime,
                isSpecial: selectedWeather == weatherData[index].id ? true : false,
                temp: weatherData[index].temp,
                humidity: weatherData[index].humidity,
                detail: weatherData[index].description,
              );
            },
            //scrollDirection: Axis.horizontal,
            itemCount: weatherData.length,
        )
      ),
    );
  }
}
