import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'package:location/location.dart';
import 'dart:io';

import '../providers/WeatherProvider.dart';
import '../modals/weather.dart';
import '../support/image_chooser.dart';
import '../widgets/WeatherTile.dart';
import '../widgets/WeatherGrid.dart';

class CurrentWeatherScreen extends StatefulWidget {
  @override
  _CurrentWeatherScreenState createState() => _CurrentWeatherScreenState();
}

class _CurrentWeatherScreenState extends State<CurrentWeatherScreen> {
  double _latitude;
  double _longitude;
  bool _isLoading;
  bool _isInit = true;

  Future<void> fetchLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    setState(() {
      _latitude = _locationData.latitude;
      _longitude = _locationData.longitude;
    });

  }

  @override
  void didChangeDependencies() {
    if(_isInit){
      setState(() {
        _isLoading = true;
      });

      fetchLocation().then((_){
        Provider.of<WeatherProvider>(context,listen: false).fetchWeatherByPosition(_latitude, _longitude).then((_){
          setState(() {
            _isLoading = false;
          });
        });
      });
    }

    _isInit = false;

    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _city = Provider.of<WeatherProvider>(context).currentCity;
    final _weather = Provider.of<WeatherProvider>(context).currentWeather.where((weather) => weather.city == _city).toList();

    Random random = new Random();
    int randomNumber = random.nextInt(3);
    var _imageUrl = clearImage[randomNumber];

    if(_weather.length != 0){
      if(_weather[0].type == WeatherType.Clear){
        _imageUrl = clearImage[randomNumber];
      }else if(_weather[0].type == WeatherType.Rain){
        _imageUrl = rainImage[randomNumber];
      }else if(_weather[0].type == WeatherType.Clouds){
        _imageUrl = cloudImage[randomNumber];
      }
    }


    return Scaffold(
      body: _isLoading || _weather.length == 0 ? Center(
        child: CircularProgressIndicator(),
      ) :
      SingleChildScrollView(
        child: Column(
            children: <Widget>[
              Stack(
                alignment: Alignment.topLeft,
                children: <Widget>[
                  Image.asset(
                    _imageUrl,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                    height: MediaQuery.of(context).size.height * 0.6,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
                    padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              (_weather[0].temp - 274.15).round().toString(),
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 50,
                                color: Colors.white,
                                fontWeight: FontWeight.w700
                              ),
                              textAlign: TextAlign.center,
                              softWrap: true,
                            ),
                            Text(
                                '  C',
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                color: Colors.white,
                                fontSize: 25
                              ),
                              softWrap: true,
                            )
                          ],
                        ),
                        Text(
                           _weather[0].type.toString().substring(12,),
                          softWrap: true,
                          style: TextStyle(
                            fontFamily: 'Itim',
                            color: Colors.white,
                            fontSize: 18
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                child: ListView.builder(
                    itemBuilder: (ctx,index){
                      return WeatherTile(
                        detail: _weather[index].description,
                        dateTime: _weather[index].dateTime,
                        max_temp: _weather[index].temp_max,
                        min_temp: _weather[index].temp_min,
                        weatherType: _weather[index].type,
                        id: _weather[index].id,
                      );
                    },
                  itemCount: 4,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: WeatherGrid(
                  humidity: _weather[0].humidity,
                  presure: _weather[0].pressure,
                  temp: _weather[0].temp,
                  windSpeed: _weather[0].wind,
                ),
              ),
            ],
          ),
      ),
    );
  }
}
