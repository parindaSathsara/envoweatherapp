import 'package:flutter/material.dart';
import 'package:envoweather/models/location.dart';
import 'package:envoweather/views/splash.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:envoweather/presenter/weatherPresenter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var list = await _getCurrentLocation;

  if(list==null){
    runApp(MyApp("New York",74.0060,40.7128));
  }
  else{
    runApp(MyApp(list[0],list[1],list[2]));
  }

}


class MyApp extends StatelessWidget {
  final String location;
  final double latitude;
  final double longitude;
  MyApp(this.location, this.longitude, this.latitude);

  Widget build(BuildContext context) {

    List<LocationF> locations = [
      LocationF(city: location, lat: latitude.toString(), lon: longitude.toString())
    ];

    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(locations),
    );
  }
}


Future<List> get  _getCurrentLocation async {

  try {
    double latitude;
    double longitude;
    String subadministrative;

    Position position =
    await getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

    latitude = position.latitude;
    longitude = position.longitude;

    List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude, longitude);
    Placemark place = placemarks[0];
    subadministrative = place.subAdministrativeArea.toString();

    return [subadministrative, longitude, latitude];
  }
  on Exception catch(_){
    return ["Colombo",79.8612 , 6.9271];
  }
}

