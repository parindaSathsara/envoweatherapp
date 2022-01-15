
class Weather {
  final double temp;
  final double low;
  final double high;
  final String description;

  final double humidity;
  final double wind;
  final String icon;
  final String lon;
  final String lat;
  final int dt;
  final int timezone;
  final int sunset;
  final int sunrise;
  final String city;

  Weather({this.temp,this.low, this.high, this.description,this.humidity, this.wind, this.icon,this.lon,this.lat,this.dt,this.timezone,this.sunrise,this.sunset,this.city});

  factory Weather.fromJson(Map<String, dynamic> json) {
    print(json);
    return Weather(
      temp: json['main']['temp'].toDouble(),
      low: json['main']['temp_min'].toDouble(),
      high: json['main']['temp_max'].toDouble(),
      description: json['weather'][0]['description'],
      humidity: json['main']['humidity'].toDouble(),
      wind: json['wind']['speed'].toDouble(),
      icon: json['weather'][0]['icon'],
      lon: json['coord']['lon'].toString(),
      lat: json['coord']['lat'].toString(),
      dt: json['dt'].toInt(),
      timezone: json['timezone'].toInt(),
      sunset: json['sys']['sunset'].toInt(),
      sunrise: json['sys']['sunrise'].toInt(),
      city: json['name'].toString(),
    );
  }

}
