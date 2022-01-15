import 'package:flutter/material.dart';
import 'package:envoweather/models/location.dart';
import 'package:envoweather/presenter/weatherPresenter.dart';
import 'package:envoweather/styles/textstyles.dart';
import 'package:envoweather/views/weatherscreen.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName;
  bool error=false;
  var weatherData="";
  WeatherPresenter _weatherPresenter=new WeatherPresenter();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Image(
            image: AssetImage("assets/BGImages/searchCity.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Center(
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: Row(
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
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Search City",
                              style: currentCondtion,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      padding: EdgeInsets.only(top: 100.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 220.0,
                                height: 60.0,
                                margin: EdgeInsets.only(right: 10.0),
                                child: TextField(
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  decoration: inputFieldsDeco,
                                  onChanged: (value) {
                                    cityName = value;
                                  },
                                ),
                              ),
                              Container(
                                height: 60.0,
                                width: 60.0,
                                child: FlatButton(
                                    color: Color(0xFF687AC3),
                                    shape: new RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    onPressed: () async {
                                      print("Button pressed");
                                      var weatherData = await _weatherPresenter.getCurrentWeatherFromCityName(cityName);

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

                                      if(weatherData!=null){
                                        List<LocationF> locations = [
                                          LocationF(
                                              city: cityName,
                                              lat: weatherData.lat,
                                              lon: weatherData.lon)
                                        ];

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    WeatherHome(
                                                        locations,backgroundname(int.parse(_weatherPresenter.getHour(weatherData.dt, weatherData.timezone))), context)))
                                            .then((value) => setState(() {
                                        }));
                                      }
                                      else{
                                        setState(() {
                                          error=true;
                                        });
                                      }


                                    },
                                    child: Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    )),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: error,
                            child: Container(
                              margin: EdgeInsets.only(top: 40.0),
                              child: Column(
                                children: [
                                  Image(
                                    image: AssetImage("assets/images/errorSearch.png"),
                                    height: 180.0,
                                    width: 180.0,
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "ENVO LOOKED EVERYWHERE",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "The city you are looking for is hard to find",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.0,
                                      color: Colors.white,

                                    ),
                                  ),
                                ],
                              ),
                            ),
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

