class SavedLocationsModel {
  final int location_id;
  final String city_name;
  final String lon;
  final String lat;

  SavedLocationsModel({
    this.location_id,
    this.city_name,
    this.lon,
    this.lat,
  });

  Map<String, dynamic> toLocationMap() {
    return {
      'location_id': location_id,
      'city_name': city_name,
      'lon': lon,
      'lat': lat,
    };
  }
}
