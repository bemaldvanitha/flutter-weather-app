import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

import '../providers/WeatherProvider.dart';

class AddCity extends StatefulWidget {
  @override
  _AddCityState createState() => _AddCityState();
}

class _AddCityState extends State<AddCity> {
   final cityController = TextEditingController();
    bool _isLoading = false;

   void saveCity(BuildContext ctx){
     final city = cityController.text.trim();
     setState(() {
       _isLoading = true;
     });

     Provider.of<WeatherProvider>(ctx,listen: false).addCity(city).then((_){
       Navigator.of(ctx).pop();
       setState(() {
         _isLoading = false;
       });
     }).catchError((err){
       showDialog(context: ctx,builder: (ctx){
         return AlertDialog(
           title: Text('City Not Found'),
           content: Text('That city Not Found try Another'),
           actions: <Widget>[
             FlatButton(
               child: Text('ok'),
               onPressed: (){
                 setState(() {
                   _isLoading = false;
                 });
                 Navigator.of(context).pop();
               },
             ),
           ],
         );
       });
     });
   }

  @override
  Widget build(BuildContext context) {
    return _isLoading ?
    Center(
      child: CircularProgressIndicator()
    ) :
    Container(
      padding: EdgeInsets.symmetric(vertical: 60,horizontal: 40),
      child: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: 'Enter City',
              icon: Icon(MaterialCommunityIcons.city),
            ),
            controller: cityController,
            keyboardType: TextInputType.text,
          ),
          SizedBox(
            height: 40,
          ),
          FlatButton(
            child: Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.25,
              decoration: BoxDecoration(
                color: Colors.orangeAccent,
              ),
              child: Text(
                  'Save',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Itim',
                  fontSize: 20
                ),
              ),
            ),
            onPressed: () => saveCity(context),
          )
        ],
      ),
    );
  }
}
