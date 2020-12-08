import 'package:flutter/material.dart';

class WeatherBox extends StatelessWidget {
  final String name;
  final double value;
  final IconData icon;
  final String unit;

  WeatherBox({
    @required this.value,
    @required this.name,
    @required this.icon,
    @required this.unit
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40,vertical: 10),
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.5,
      decoration: BoxDecoration(
        border: Border.all(width: 1,style: BorderStyle.solid,color: Colors.black),
        gradient: LinearGradient(
          colors: [
            Colors.blueAccent[200],
            Colors.blue[200]
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft
        )
      ),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                  name,
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                  value.toString() + ' '+ unit,
                softWrap: true,
                  style: TextStyle(
                    fontFamily: 'Itim',
                    fontSize: 14
                  ),
              ),
            ],
          ),
          Icon(icon)
        ],
      ),
    );
  }
}
