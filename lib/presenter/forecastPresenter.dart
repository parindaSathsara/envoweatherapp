import 'dart:convert';
import 'package:envoweather/presenter/apikey.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:envoweather/models/forcast.dart';
import 'package:envoweather/models/location.dart';
import 'package:envoweather/models/weather.dart';

class ForecastPresenter{

  Future getForecast(LocationF location) async {
    Forecast forecast;
    String apiKey = apikey;
    String lat = location.lat;
    String lon = location.lon;
    var url =
        "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&appid=$apiKey&units=metric";

    final response = await http.get(url);

    if (response.statusCode == 200) {
      forecast = Forecast.fromJson(jsonDecode(response.body));
    }

    return forecast;
  }


  Image showWeatherIcon(String _icon) {
    String path = 'assets/openWeatherIcons/';
    String type = ".png";
    return Image.asset(
      path + _icon + type,
      width: 50,
      height: 50,
    );
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

  String showDate(int timestamp) {
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var formatter = new DateFormat('EEEE');
    return formatter.format(date);
  }

  String showLongDate(int timestamp) {
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var formatter = new DateFormat('dd/MM');
    return formatter.format(date);
  }

  String showTime(int timestamp,int timezoneF) {
    var timezone=timezoneF;
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000,isUtc: true);
    var finaldate=date.add(new Duration(seconds:timezone));
    var formatter = new DateFormat('h:mm a');
    return formatter.format(finaldate);
  }





}



