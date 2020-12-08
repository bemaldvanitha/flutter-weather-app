import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/current_weather_screen.dart';
import './screens/weather_detail_screen.dart';
import './screens/city_weather_screen.dart';
import './screens/settings_screen.dart';
import './screens/tab_screen.dart';
import './providers/WeatherProvider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx){
            return WeatherProvider();
          },
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Raleway',
          primaryColor: Colors.green,
          accentColor: Colors.lightGreenAccent,
        ),
        title: 'Weather App',
        home: TabScreen(),
        routes: {
          '/current': (ctx) => CurrentWeatherScreen(),
          '/weatherDetail': (ctx) => WeatherDetailScreen(),
          '/city': (ctx) => CityWeatherScreen(),
          '/settings': (ctx) => SettingsScreen(),
        },
      ),
    );
  }
}
