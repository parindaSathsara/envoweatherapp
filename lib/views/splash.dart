import 'dart:async';
import 'package:flutter/material.dart';
import 'package:envoweather/models/location.dart';
import 'package:envoweather/views/weatherscreen.dart';

class SplashScreen extends StatefulWidget {

  final List<LocationF> locations;

  const SplashScreen(this.locations);

  @override
  _SplashScreenState createState() => _SplashScreenState(this.locations);
}

class _SplashScreenState extends State<SplashScreen> {
  var timeNow = DateTime.now().hour;

  final List<LocationF> locations;
  _SplashScreenState(List<LocationF> locations):
      this.locations=locations;

  String backgroundname(int timeNow){
    if ((timeNow > 06) && (timeNow <= 12)) {
      return '1';
    } else if ((timeNow > 12) && (timeNow <= 16)) {
      return '2';
    } else if ((timeNow >= 17) && (timeNow < 19)) {
      return '3';
    }
    else if ((timeNow >= 19) && (timeNow < 23)) {
      return '4';
    }
    else {
      return '5';
    }
  }
  @override
  void initState() {
    super.initState();

    Timer(
      Duration(seconds: 4),
          () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WeatherHome(locations,backgroundname(timeNow), context),
        ),
      ),
    );

  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Image.asset(
                  "assets/images/applogo.png",
                  height: 350.0,
                  width: 350.0,
                ),
              ],
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0XFF34CCF9)),
            ),
          ],
        ),
      ),
    );
  }
}
