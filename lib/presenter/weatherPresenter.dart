import 'dart:convert';
import 'package:envoweather/presenter/apikey.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:envoweather/models/location.dart';
import 'package:envoweather/models/weather.dart';

class WeatherPresenter{

  Future getCurrentWeather(LocationF location) async {
    Weather weather;
    String city = location.city;
    String apiKey = apikey;
    var url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";

    final response = await http.get(url);

    if (response.statusCode == 200) {
      weather = Weather.fromJson(jsonDecode(response.body));
    }

    return weather;
  }


  Image showWeatherIconSmall(String _icon) {
    String path = 'assets/openWeatherIcons/';
    String type = ".png";
    return Image.asset(
      path + _icon + type,
      width: 40,
      height: 40,
    );
  }

  String showLongDate(int timestamp,int timezone) {
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000,isUtc: true);
    var finaldate=date.add(new Duration(seconds:timezone));
    var formatter = new DateFormat('E d MMMM hh:mm a');
    return formatter.format(finaldate);
  }

  Image showWeatherMainIcon(String _icon) {
    String path = 'assets/openWeatherIcons/';
    String imageExtension = ".png";
    return Image.asset(
      path + _icon + imageExtension,
      width: 70,
      height: 70,
    );
  }
  String getTime(int timestamp,int timezoneF) {
    var timezone=timezoneF;
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000,isUtc: true);
    var finaldate=date.add(new Duration(seconds:timezone));
    var formatter = new DateFormat('h:mm a');
    return formatter.format(finaldate);
  }
  Future getCurrentWeatherFromCityName(String location) async {
    Weather weather;
    String city = location;
    String apiKey = apikey;
    var url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";

    final response = await http.get(url);

    if (response.statusCode == 200) {
      weather = Weather.fromJson(jsonDecode(response.body));
    }

    return weather;
  }
  String getHour(int timestamp,int timezone) {
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000,isUtc: true);
    var finaldate=date.add(new Duration(seconds:timezone));
    var formatter = new DateFormat('H');
    return formatter.format(finaldate);
  }


}



