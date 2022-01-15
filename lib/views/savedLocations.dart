import 'package:flutter/material.dart';
import 'package:envoweather/models/db/dbhelper.dart';
import 'package:envoweather/models/db/savedlocations_model.dart';
import 'package:envoweather/models/location.dart';
import 'package:envoweather/models/weather.dart';
import 'package:envoweather/presenter/dbPresenter.dart';
import 'package:envoweather/presenter/weatherPresenter.dart';
import 'package:envoweather/styles/loadingIndicator.dart';
import 'package:envoweather/styles/textstyles.dart';
import 'package:envoweather/views/weatherscreen.dart';

class SavedLocations extends StatefulWidget {
  final List<LocationF> locations;
  final BuildContext context;
  final String background;

  const SavedLocations(this.locations, this.background, this.context);

  @override
  _SavedLocationsState createState() =>
      _SavedLocationsState(this.locations, this.background, this.context);
}

class _SavedLocationsState extends State<SavedLocations> {
  SavedLocationsModel savedLocations = new SavedLocationsModel();
  DBHelper _dbHelper = new DBHelper();
  WeatherPresenter _weatherPresenter = new WeatherPresenter();
  DBPresenter _dbPresenter=new DBPresenter();
  Weather weather = new Weather();

  bool deleted=false;

  final List<LocationF> locationsMain;
  final BuildContext context;
  final String background;

  _SavedLocationsState(List<LocationF> locations, String background, BuildContext context)
      : this.locationsMain = locations,
        this.context = context,
        this.background = background;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          if(deleted==true){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => WeatherHome(locationsMain, background, context)));
                          }
                          else{
                            Navigator.pop(context);
                          }
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
                          "Saved Locations",
                          style: TitleText,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top: 30.0),
                      child: FutureBuilder(
                        future: _dbHelper.getLocations(),
                        builder: (context, AsyncSnapshot<List> snapshot) {
                          var snapdata = 0;
                          if (snapshot.hasData) {
                            snapdata = snapshot.data.length;
                          } else {
                            snapdata = 0;
                          }
                          return ScrollConfiguration(
                            behavior: NoGlow(),
                            child: ListView.builder(
                              itemCount: snapdata,
                              itemBuilder: (context, index) {
                                String city_name=snapshot.data[index].city_name.toString().toUpperCase();
                                String city=snapshot.data[index].city_name.toString();
                                String lat=snapshot.data[index].lat;
                                String lon=snapshot.data[index].lon;

                                return Dismissible(
                                  key: UniqueKey(),
                                  confirmDismiss: (direction) {
                                    return Future.value(direction == DismissDirection.endToStart);
                                  },
                                  onDismissed: (direction) {
                                    _dbPresenter.deleteLocation(city);
                                    setState(() => deleted = true);
                                  },



                                  child: GestureDetector(
                                    onTap: () async {

                                      var weatherData = await _weatherPresenter.getCurrentWeatherFromCityName(city_name);

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


                                      List<LocationF> locations = [
                                        LocationF(
                                            city: city_name,
                                            lat: lat,
                                            lon: lon)
                                      ];

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  WeatherHome(
                                                      locations,backgroundname(int.parse(_weatherPresenter.getHour(weatherData.dt, weatherData.timezone))), context)))
                                          .then((value) => setState(() {
                                      }));

                                    },
                                    child: FutureBuilder(
                                      future: _weatherPresenter.getCurrentWeatherFromCityName(snapshot.data[index].city_name),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          weather = snapshot.data;
                                          if (weather == null) {
                                            return Text("Error getting weather");
                                          } else {
                                            return locations(city_name, weather,_weatherPresenter);
                                          }
                                        } else {
                                          return Center(
                                              child: circularProgressGrey());
                                        }
                                      },

                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget locations(String city_name, Weather weather, WeatherPresenter _weatherPresenter) {
  return Container(
    padding: const EdgeInsets.only(left: 30, top: 18, bottom: 5, right: 30),
    margin: EdgeInsets.only(bottom: 20.0),
    height: 115,
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white,
      boxShadow: const [
        BoxShadow(
          offset: Offset(2.0, 2.0),
          blurRadius: 5.0,
          color: Color.fromARGB(10, 0, 0, 0),
        )
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            children: [
              Container(
                child: Text(
                  city_name,
                  style: TitleText,
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    Text(
                      "${weather.temp.toInt()}°C",
                      textAlign: TextAlign.right,
                      style: moreInfoText,
                    ),
                    _weatherPresenter.showWeatherIconSmall(weather.icon),
                  ],
                ),
              ),
              Container(
                child: Text(
                  weather.description.toUpperCase(),
                  style: moreInfoTextSecondary,
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: Container(
            padding: EdgeInsets.only(top: 22),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 100.0,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Image(
                          image: AssetImage(
                            "assets/openWeatherIcons/img_1.png",
                          ),
                          height: 30.0,

                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Max ${weather.high.toInt()}°C",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13.0,
                              fontWeight: FontWeight.w500,
                              color: Color(0XFFFF7D47),
                            ),
                          ),
                          Text(
                            "Min  ${weather.low.toInt()}°C",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13.0,
                              fontWeight: FontWeight.w500,
                              color: Color(0XFF91BCFE),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),

      ],
    ),
  );
}

class NoGlow extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
