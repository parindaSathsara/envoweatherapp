import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:decorated_icon/decorated_icon.dart';
import 'package:envoweather/views/citySearch.dart';
import 'package:envoweather/models/db/dbhelper.dart';
import 'package:envoweather/presenter/dbPresenter.dart';
import 'package:envoweather/views/dateforecast.dart';
import 'package:envoweather/views/hourlydetailed.dart';
import 'package:envoweather/models/forcast.dart';
import 'package:envoweather/models/location.dart';
import 'package:envoweather/models/weather.dart';
import 'package:envoweather/presenter/forecastPresenter.dart';
import 'package:envoweather/presenter/weatherPresenter.dart';
import 'package:envoweather/styles/loadingIndicator.dart';
import 'package:envoweather/styles/textstyles.dart';
import 'package:envoweather/views/savedLocations.dart';

class WeatherHome extends StatefulWidget {
  final List<LocationF> locations;
  final BuildContext context;
  final String background;

  const WeatherHome(this.locations, this.background, this.context);

  @override
  _WeatherHomeState createState() =>
      _WeatherHomeState(this.locations, this.background, this.context);
}

class _WeatherHomeState extends State<WeatherHome> {
  final List<LocationF> locations;
  final LocationF location;
  final BuildContext context;
  final String background;
  Weather _weather;
  Forecast _forcast;


  _WeatherHomeState(List<LocationF> locations, background, BuildContext context)
      : this.locations = locations,
        this.context = context,
        this.location = locations[0],
        this.background = background;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  WeatherPresenter _weatherPresenter = new WeatherPresenter();
  ForecastPresenter _forecastPresenter = new ForecastPresenter();
  DBPresenter _dbPresenter = DBPresenter();

  bool isStarPressed = false;



  int number = 0;

  DBHelper db = new DBHelper();

  void initState(){
    super.initState();
    db.getCityStatus(location.city.toTitleCase()).then((value) {
      setState(() {
        if (value > 0) {
          isStarPressed=true;
        } else {
          isStarPressed = false;
        }
      });

    });
  }


  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Image(
            image: setBackground(background),
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.all(10),
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: Image(
                      width: 300.0,
                      height: 300.0,
                      image: AssetImage("assets/images/applogo.png")),
                ),
                ListTile(
                  leading: Icon(
                    Icons.calendar_today,
                    color: sidebarText.color,
                  ),
                  title: Text(
                    "Daily Forecast",
                    style: sidebarText,
                  ),
                  selectedTileColor: Colors.black,
                  onTap: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    dateForecast(locations, context)))
                        .then((value) => setState(() {}));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.timelapse_rounded,
                    color: sidebarText.color,
                  ),
                  title: Text(
                    "Today Forecast",
                    style: sidebarText,
                  ),
                  selectedTileColor: Colors.black,
                  onTap: () {
                    List<LocationF> locations = [
                      LocationF(
                          city: location.city,
                          lat: _weather.lat,
                          lon: _weather.lon,
                          timezone: _weather.timezone)
                    ];
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    hourlyForecast(locations, context)))
                        .then((value) => setState(() {}));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.star,
                    color: sidebarText.color,
                  ),
                  title: Text(
                    "Saved Locations",
                    style: sidebarText,
                  ),
                  selectedTileColor: Colors.black,
                  onTap: () {
                    /*
                    List<Location> locations = [
                      Location(city: location.city,lat: weather.lat, lon: weather.lon,timezone: weather.timezone)
                    ];
                    */
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SavedLocations(locations,background,context)))
                        .then((value) => setState(() {}));
                  },
                ),
              ],
            ),
          ),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Center(
                child: Stack(
                  children: [
                    Positioned(
                      top: 15.0,
                      left: 15.0,
                      child: InkWell(
                        splashColor: Colors.pink.shade50,
                        borderRadius: BorderRadius.circular(10.0),
                        onTap: () => _scaffoldKey.currentState.openDrawer(),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Image(
                            image: AssetImage(
                                "assets/openWeatherIcons/sidebaropen.png"),
                            height: 18,
                            width: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 13.0,
                      left: 53.0,
                      child: InkWell(
                        splashColor: Colors.pink.shade50,
                        borderRadius: BorderRadius.circular(10.0),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      WeatherHome(locations,background,context)))
                              .then((value) => setState(() {
                          }));
                        },
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.refresh,
                            size: 23,
                            color: Colors.white,
                          )
                        ),
                      ),
                    ),
                    Positioned(
                      top: 15.0,
                      right: 15.0,
                      child: InkWell(
                        splashColor: Colors.pink.shade50,
                        borderRadius: BorderRadius.circular(10.0),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CityScreen()),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.all(7),
                          child: Icon(
                            Icons.search,
                            size: 24.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 15.0,
                      right: 55.0,
                      child: InkWell(
                        splashColor: Colors.pink.shade50,
                        borderRadius: BorderRadius.circular(10.0),
                        onTap: () {

                          if(isStarPressed==false){
                            _dbPresenter.insertTask(
                                location.city, location.lon, location.lat);

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(location.city.toTitleCase()+" City added to saved locations"),
                            ));

                          }
                          else{
                            _dbPresenter.deleteLocation(location.city);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(location.city.toTitleCase()+" City removed from saved locations"),
                            ));
                          }
                          setState(() {
                            if (isStarPressed == true) {
                              isStarPressed = false;
                            } else {
                              isStarPressed = true;
                            }
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.all(7),
                          child: (isStarPressed)
                              ? starredLocation(Icons.star)
                              : starredLocation(Icons.star_outline_sharp),
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 40),
                      child: Column(
                        children: [
                          FutureBuilder(
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                _weather = snapshot.data;
                                String city = _weather.city;
                                if (_weather == null) {
                                  return Text("Weather Error");
                                } else {
                                  return Column(children: [
                                    currentWeather(
                                        location, _weather, _weatherPresenter),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    currentMoreInfo(_weather),
                                  ]);
                                }
                              } else {
                                return Center(child: circularProgress());
                              }
                            },
                            future:
                                _weatherPresenter.getCurrentWeather(location),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          FutureBuilder(
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                _forcast = snapshot.data;
                                if (_forcast == null) {
                                  return Text("Forecast Error");
                                } else {
                                  return forecast(_forcast, _weather.timezone,_forecastPresenter);
                                }
                              } else {
                                return Center(child: circularProgress());
                              }
                            },
                            future: _forecastPresenter.getForecast(location),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget currentWeather(
    LocationF location, Weather _weather, WeatherPresenter _weatherPresenter) {
  return Stack(
    children: [
      Positioned(
        right: 42.0,
        top: 90.0,
        child: _weatherPresenter.showWeatherMainIcon(_weather.icon),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DecoratedIcon(
            Icons.location_on,
            color: Colors.white,
            size: 28.0,
            shadows: cityNameText.shadows,
          ),
          Container(
            margin: EdgeInsets.only(left: 5),
            child: Text(
              location.city.toUpperCase(),
              textAlign: TextAlign.center,
              style: cityNameText,
            ),
          ),
        ],
      ),
      Center(
        child: Container(
          margin: EdgeInsets.only(top: 32.0),
          child: Text(
            "${_weatherPresenter.showLongDate(_weather.dt, _weather.timezone)}",
            textAlign: TextAlign.center,
            style: timeText,
          ),
        ),
      ),
      Center(
        child: Container(
          margin: EdgeInsets.only(top: 40.0),
          child: Text(
            "${_weather.temp.toInt()}°",
            textAlign: TextAlign.center,
            style: currentTemp,
          ),
        ),
      ),
      Center(
        child: Container(
          margin: EdgeInsets.only(top: 155.0),
          child: Text(
            "${_weather.description.toUpperCase()}",
            textAlign: TextAlign.center,
            style: currentCondtion,
          ),
        ),
      ),
    ],
  );
}

Widget currentMoreInfo(Weather _weather) {
  return Container(
    padding: const EdgeInsets.only(left: 15, top: 26, bottom: 5, right: 15),
    height: 110,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            offset: Offset(2.0, 2.0),
            blurRadius: 8.0,
            color: Color.fromARGB(25, 0, 0, 0),
          )
        ]),
    child: Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Image(
                  image: AssetImage("assets/openWeatherIcons/img.png"),
                  height: 25,
                  color: moreInfoText.color,
                ),
              ),
              Container(
                child: Text(
                  "Max Temp",
                  textAlign: TextAlign.center,
                  style: moreInfoTextSecondary,
                ),
              ),
              Container(
                child: Text(
                  "${_weather.high.toInt()}°C",
                  textAlign: TextAlign.left,
                  style: moreInfoText,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Image(
                  image: AssetImage("assets/openWeatherIcons/humidity.png"),
                  height: 25,
                  color: moreInfoText.color,
                ),
              ),
              Container(
                child: Text(
                  "Humidity",
                  textAlign: TextAlign.center,
                  style: moreInfoTextSecondary,
                ),
              ),
              Container(
                child: Text(
                  "${_weather.humidity.toInt()}%",
                  textAlign: TextAlign.left,
                  style: moreInfoText,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Image(
                  image: AssetImage("assets/openWeatherIcons/wind.png"),
                  height: 25,
                ),
              ),
              Container(
                child: Text("Wind",
                    textAlign: TextAlign.center, style: moreInfoTextSecondary),
              ),
              Container(
                child: Text(
                  "${_weather.wind.toString()}m/s",
                  textAlign: TextAlign.left,
                  style: moreInfoText,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget forecast(
    Forecast _forecast, int timezone, ForecastPresenter _forecastPresenter) {
  return Container(
    padding: EdgeInsets.only(top: 5.0),
    height: 125.0,
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
        height: 115.0,
        child: ListView.builder(
          padding:
              const EdgeInsets.only(left: 8, top: 10, bottom: 13, right: 8),
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
                  _forecastPresenter
                      .showWeatherIcon(_forecast.hourly[index].icon),
                  Text(
                    _forecastPresenter.showTime(_forecast.hourly[index].dt, timezone == null ? 9000:timezone),
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

Icon starredLocation(IconData iconData) {
  return Icon(
    iconData,
    size: 24.0,
    color: Colors.white,
  );
}

AssetImage setBackground(String background) {
  String path = 'assets/BGImages/';
  String imageExtension = ".jpg";
  return AssetImage(
    path + background + imageExtension,
  );
}

extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}
