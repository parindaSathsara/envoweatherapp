class Hourly {
  final int dt;
  final int timezone;
  final double temp;
  final String description;
  final String icon; 

  Hourly({this.dt,this.timezone, this.temp,this.description, this.icon});

  factory Hourly.fromJson(Map<String, dynamic> json) {
    return Hourly(
      dt: json['dt'].toInt(),
      temp: json['temp'].toDouble(),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
    );
  }
}