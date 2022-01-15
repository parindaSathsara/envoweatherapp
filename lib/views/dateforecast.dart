import 'package:envoweather/styles/loadingIndicator.dart';
import 'package:flutter/material.dart';
import 'package:envoweather/models/forcast.dart';
import 'package:envoweather/models/location.dart';
import 'package:envoweather/presenter/forecastPresenter.dart';
import 'package:envoweather/styles/textstyles.dart';

class dateForecast extends StatefulWidget {
  final List<LocationF> locations;
  final BuildContext context;

  const dateForecast(this.locations, this.context);

  @override
  _dateForecastState createState() =>
      _dateForecastState(this.locations, this.context);


}

class _dateForecastState extends State<dateForecast> {
  final List<LocationF> locations;
  final LocationF location;
  final BuildContext context;
  Forecast _forecast;
  ForecastPresenter _forecastPresenter=new ForecastPresenter();

  _dateForecastState(List<LocationF> locations, BuildContext context)
      : this.locations = locations,
        this.context = context,
        this.location = locations[0];

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
                          "Daily Weather Forecast",
                          style: TitleText,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: FutureBuilder(
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            _forecast = snapshot.data;
                            if (_forecast == null) {
                              return Text("Forecast Error");
                            } else {
                              return dailyBoxes(_forecast,_forecastPresenter);
                            }
                          } else {
                            return Center(child: circularProgressGrey());
                          }
                        },
                        future: _forecastPresenter.getForecast(location),
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

Widget dailyBoxes(Forecast _forcast,ForecastPresenter _forecastPresenter) {
  return Container(
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: _forcast.daily.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding:
          const EdgeInsets.only(left: 5, top: 5, bottom: 10, right: 5),
          margin: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 5.0,top:10.0),
                      child: Text(
                        "${_forecastPresenter.showDate(_forcast.daily[index].dt)}",
                        style: moreInfoText,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.date_range,
                          size: 20.0,
                          color: dateText.color,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 3.0, top: 3.0),
                          child: Text(
                            "${_forecastPresenter.showLongDate(_forcast.daily[index].dt)}",
                            style: dateText,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: 100.0,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Column(
                          children: [

                            Row(
                              mainAxisAlignment:MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${_forcast.daily[index].temp.toInt()}°C",
                                  textAlign: TextAlign.right,
                                  style: moreInfoText,
                                ),
                                _forecastPresenter.showWeatherIconSmall(_forcast.daily[index].icon),
                              ],
                            ),

                            Text(
                              "${_forcast.daily[index].description.toUpperCase()}",
                              style: moreInfoTextSecondary,
                              textAlign: TextAlign.center,
                            ),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                "Max ${_forcast.daily[index].high.toInt()}°C",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0XFFFF7D47),
                                ),
                              ),
                              Text(
                                "Min  ${_forcast.daily[index].low.toInt()}°C",
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
            ],
          ),
        );
      },
    ),
  );
}




