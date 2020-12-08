import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../screens/city_weather_screen.dart';
import '../screens/current_weather_screen.dart';
import '../screens/settings_screen.dart';

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Weather App'),
          centerTitle: true,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Weather',
                icon: Icon(MaterialCommunityIcons.weather_cloudy),
              ),
              Tab(
                text: 'City',
                icon: Icon(MaterialCommunityIcons.city),
              ),
              Tab(
                text: 'Settings',
                icon: Icon(MaterialCommunityIcons.settings),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            CurrentWeatherScreen(),
            CityWeatherScreen(),
            SettingsScreen()
          ],
        ),
      ),
    );
  }
}
