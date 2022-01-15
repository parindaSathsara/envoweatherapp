class Daily {
  final int dt;
  final double temp;
  final double low;
  final double high;
  final String description;
  final String icon;

  Daily({this.dt, this.temp,this.low, this.high, this.description, this.icon});

  factory Daily.fromJson(Map<String, dynamic> json) {
    return Daily(
      dt: json['dt'].toInt(),
      temp: json['temp']['day'].toDouble(),
      low: json['temp']['min'].toDouble(),
      high: json['temp']['max'].toDouble(),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],

    );
  }
}