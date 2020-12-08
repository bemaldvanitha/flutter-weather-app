import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/AddCity.dart';
import '../widgets/CityWether.dart';
import '../providers/WeatherProvider.dart';

class CityWeatherScreen extends StatelessWidget {

  void _showModalBottomSheet(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (_){
      return AddCity();
    });
  }

  @override
  Widget build(BuildContext context) {
    final _weatherList = Provider.of<WeatherProvider>(context).differentWeather;
    return Scaffold(
      body: ListView.builder(
          itemBuilder: (ctx,index){
            return CityWeather(
              city: _weatherList[index].city,
              temp: _weatherList[index].temp,
              highTemp: _weatherList[index].temp_max,
              lowTemp: _weatherList[index].temp_min,
            );
          },
        itemCount: _weatherList.length,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showModalBottomSheet(context),
        elevation: 5,
        backgroundColor: Colors.lightGreen,
      ),
    );
  }
}
