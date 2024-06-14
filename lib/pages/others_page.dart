// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:minimal_weather_app/Templates/SmallWeather.dart';
import 'package:minimal_weather_app/models/weather_model.dart';
import 'package:minimal_weather_app/pages/others_page.dart';
import 'package:minimal_weather_app/services/weather_services.dart';
import 'package:minimal_weather_app/pages/weather_page.dart';

class OtherPage extends StatefulWidget {
  const OtherPage({super.key});

  @override
  State<OtherPage> createState() => _OtherPageState();
}

class _OtherPageState extends State<OtherPage> {
  final _weatherService = WeatherService('7f16949fdfa98b2cb71bfe4b57c34ac9');

  Weather? _weather;

  List<String> namesCity = [
    'Bangalore',
    'Barcelona',
    'Madrid',
    'York',
    'Delhi',
    'London',
    'Southampton'
  ];

  Future<Weather?> __fetchWeatherByCity(String cityName) async {
    try {
      return await _weatherService.getWeather(cityName);
    } catch (e, s) {
      print(e);
      debugPrintStack(stackTrace: s);
      return null;
    }
  }

  List<Weather> weathers = [];

  __fetchWeatherForCities() async {
    final response = await Future.wait(namesCity.map(__fetchWeatherByCity))
        .then((it) => it.whereType<Weather>().toList());
    setState(() {
      weathers = response;
    });
  }

  _fetchWeather(String cityName) async {
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  Color? topColor() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return Colors.amberAccent[200];
    }
    if (hour < 19) {
      return Colors.blueAccent;
    }
    return Color(0xFFFFAB40);
  }

  Color? bottomColor() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return Colors.deepOrangeAccent[200];
    }
    if (hour < 19) {
      return Colors.blueGrey;
    }
    return Color(0xFF673AB7);
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/Sunny.json';
    switch (mainCondition?.toLowerCase()) {
      case 'clouds':
        return 'assets/clouds.json';
      case 'mist':
        return 'assets/haze.json';
      case 'smoke':
      case 'dust':
      case 'rain':
        return 'assets/sunrain.json';
      case 'haze':
        return 'assets/haze.json';
      case 'fog':
        return 'assets/fog.json';
      case 'drizzle':
      case 'shower rain':
        return 'assets/OvercastRainy.json';
      case 'thunderstorm':
        return 'assets/Thunderstorm.json';
      default:
        return 'assets/Sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    __fetchWeatherForCities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: bottomColor()),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-3, -0.3),
                child: Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: bottomColor(),
                    )),
              ),
              Align(
                alignment: const AlignmentDirectional(0, -1.2),
                child: Container(
                  height: 300,
                  width: 600,
                  decoration: BoxDecoration(color: topColor()),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                ),
              ),
              ListView.builder(
                itemCount: weathers.length,
                itemBuilder: (context, index) {
                  final weather = weathers[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Smallweather(weather: weather),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
