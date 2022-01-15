import 'package:flutter/material.dart';
import 'package:envoweather/models/forcast.dart';
import 'package:envoweather/models/location.dart';
import 'package:envoweather/models/weather.dart';
import 'package:envoweather/presenter/forecastPresenter.dart';
import 'package:envoweather/presenter/weatherPresenter.dart';
import 'package:envoweather/styles/loadingIndicator.dart';
import 'package:envoweather/styles/textstyles.dart';


class hourlyForecast extends StatefulWidget {
  final List<LocationF> locations;
  final BuildContext context;

  const hourlyForecast(this.locations, this.context);

  @override
  _hourlyForecastState createState() =>
      _hourlyForecastState(this.locations, this.context);
}

class _hourlyForecastState extends State<hourlyForecast> {
  final List<LocationF> locations;
  final LocationF location;
  final BuildContext context;
  Forecast _forcast;
  Weather weather;

  ForecastPresenter _forecastPresenter=new ForecastPresenter();
  WeatherPresenter _weatherPresenter=new WeatherPresenter();

  _hourlyForecastState(List<LocationF> locations, BuildContext context)
      : this.locations = locations,
        this.context = context,
        this.location = locations[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          borderRadius: BorderRadius.circular(10.0),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: 25,
                              height: 25,
                              child: Icon(
                                Icons.arrow_back,
                                color: TitleText.color,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Today Weather Forecast",
                            style: TitleText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: FutureBuilder(
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    weather = snapshot.data;
                    if (weather == null) {
                      return Text("Error getting weather");
                    } else {
                      return sunriseset(weather,location,_weatherPresenter);
                    }
                  } else {
                    return Center(child: circularProgressGrey());
                  }
                },
                future:_weatherPresenter.getCurrentWeather(location),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              height: 150,
              child: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      _forcast = snapshot.data;
                      if (_forcast == null) {
                        return Text("Forecast Error");
                      } else {
                        return hourlyBoxes(_forcast, location.timezone,_forecastPresenter);
                      }
                    } else {
                      return Center(child: circularProgressGrey());
                    }
                  },
                  future:_forecastPresenter.getForecast(location),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

Widget sunriseset(Weather weather,LocationF location, WeatherPresenter _weatherPresenter) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 20.0),
    padding: EdgeInsets.only(bottom: 10.0),
    height: 180.0,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(30)),
      boxShadow: const [
        BoxShadow(
          offset: Offset(2.0, 2.0),
          blurRadius: 8.0,
          color: Color.fromARGB(25, 0, 0, 0),
        )
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(right: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100.0,
                height: 100.0,
                child: Image(
                  image: AssetImage("assets/images/sunrise.png"),
                ),
              ),
              Text(
                _weatherPresenter.getTime(weather.sunrise, location.timezone),
                style: moreInfoText,
              ),
              Text(
                "Sunrise",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFf8981d),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100.0,
                height: 100.0,
                child: Image(
                  image: AssetImage("assets/images/sunset.png"),
                ),
              ),
              Text(
                _weatherPresenter.getTime(weather.sunset, location.timezone),
                style: moreInfoText,
              ),
              Text(
                "Sunset",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFf05a2d),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget hourlyBoxes(Forecast _forecast, int timezone, ForecastPresenter _forecastPresenter) {
  return Container(
    padding: EdgeInsets.only(top: 10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(30)),
      boxShadow: const [
        BoxShadow(
          offset: Offset(2.0, 2.0),
          blurRadius: 8.0,
          color: Color.fromARGB(25, 0, 0, 0),
        )
      ],
    ),
    child: ShaderMask(
      shaderCallback: (Rect rect) {
        return LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [
            Colors.white,
            Colors.transparent,
            Colors.transparent,
            Colors.white
          ],
          stops: [
            0.0,
            0.1,
            0.9,
            1.0
          ], // 10% purple, 80% transparent, 10% purple
        ).createShader(rect);
      },
      blendMode: BlendMode.dstOut,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 0.0),
        child: ListView.builder(
          padding: const EdgeInsets.only(left: 8, top: 12, bottom: 20, right: 8),
          scrollDirection: Axis.horizontal,
          itemCount: _forecast.hourly.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(

              margin: const EdgeInsets.only(right: 0.0),
              width: 100,
              child: Column(
                children: [
                  Text(
                    "${_forecast.hourly[index].temp}°C",
                    style: moreInfoText,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 3),
                      child: Text(
                        "${_forecast.hourly[index].description.toUpperCase()}",
                        style: miniDescription,
                      ),
                    ),
                  ),
                  _forecastPresenter.showWeatherIcon(_forecast.hourly[index].icon),
                  Text(
                    "${_forecastPresenter.showTime(_forecast.hourly[index].dt, timezone)}",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.grey),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ),
  );
}

