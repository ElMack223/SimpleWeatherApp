import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../models/weatherModel.dart';
import 'package:http/http.dart' as http;
class WeatherService{
  static const BASE_URL = 'http://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather>getWeather(String cityname)async{
    final response = await http.get(Uri.parse('$BASE_URL?q=$cityname&appid=$apiKey&units=metric'));
        if(response.statusCode == 200) {
          return Weather.fromJson(jsonDecode(response.body));
        }else {
          throw Exception('Failed to load weather data');
        }
        }

        Future<String> getCurrentCity() async {
        //Get permission from user
        LocationPermission permission = await Geolocator.checkPermission();
        if(permission == LocationPermission.denied){
          permission = await Geolocator.requestPermission();
        }
        // fetch the current location
         Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
  );
          //convert the location into a list of placemark Objects
          List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
          //extract the city name the first placemarks
          String? city = placemarks[0].locality;
          //if null return blank string
          return city ?? "";
        }
  }
