import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:envoweather/models/db/savedlocations_model.dart';

class DBHelper{

  Future<Database> database() async{
    return openDatabase(
      join(await getDatabasesPath(), 'envoweather.db'),
      onCreate: (db, version) async{
        await db.execute(
          'CREATE TABLE savedlocations(location_id INTEGER PRIMARY KEY AutoIncrement, city_name TEXT,lon TEXT, lat TEXT)',
        );
      },
      version: 1,
    );
  }


  Future<void> newLocation(SavedLocationsModel savedLocations) async {
    Database _database = await database();
    await _database.insert('savedlocations', savedLocations.toLocationMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }



  Future<int> getCityStatus(String city) async {
    Database _database = await database();
    var result = await _database.query('savedlocations',where:'city_name=? collate nocase', whereArgs: [city]);
    int count = result.length;
    print(count);
    return count;
  }




  Future<void> deleteLocation(String city) async {
    Database _database = await database();
    await _database.delete('savedlocations',where:'city_name=? collate nocase', whereArgs: [city]);
  }



  Future<List<SavedLocationsModel>> getLocations() async {
    Database _database = await database();
    List<Map<String,dynamic>> locationMap;

    locationMap = await _database.query('savedlocations');

    return List.generate(locationMap.length, (index){
      return SavedLocationsModel(location_id: locationMap[index]['task_id'],city_name: locationMap[index]['city_name'],lon: locationMap[index]['lon'],lat: locationMap[index]['lat']);
    });
  }


}