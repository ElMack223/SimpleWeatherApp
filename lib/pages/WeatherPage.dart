import 'package:flutter/material.dart';
import 'package:simple_weather_app/services/weather_service.dart';

import '../models/weatherModel.dart';

const String apiKey = '2cefb84da1bc793f15a839e1f97a3fa3';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});
  
  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  //api key 
  final _weatherService = WeatherService(apiKey);
  Weather? _weather;

  //fetch weather
  _fetchWeather() async {
    //get the current city
    String cityName = await _weatherService.getCurrentCity();

    //get weather for city

    try{
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }catch (e) 
    {
      print(e);
    }
  }

  //init state
  @override
  void initState() {

    super.initState();
    //fetch waetheer on state startup
    _fetchWeather();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? "loading city .."),

            Text('${_weather?.temperature.round() }C')
          ],
        ),
      )
    );
  }
}
//Weather Animation



