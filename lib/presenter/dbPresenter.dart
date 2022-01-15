import 'package:envoweather/models/db/dbhelper.dart';
import 'package:envoweather/models/db/savedlocations_model.dart';

class DBPresenter {
  DBHelper _dbhelper = DBHelper();

  Future<void> insertTask(String city_name, String lon,String lat) async {
    SavedLocationsModel _newLocation = SavedLocationsModel(
      city_name: city_name,
      lon: lon,
      lat: lat,
    );
    await _dbhelper.newLocation(_newLocation);
  }


  Future<void> deleteLocation(String city_name)async {
    await _dbhelper.deleteLocation(city_name);
  }
}
