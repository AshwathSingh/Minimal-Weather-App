import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:minimal_weather_app/models/weather_model.dart';

class Smallweather extends StatelessWidget {
  const Smallweather({super.key, required this.weather});
  final Weather weather;

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
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          color: Colors.white38,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${weather?.feelsLike.round()}° ${weather?.mainCondition}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      '${weather?.cityName}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        width: 80,
                        child: Lottie.asset(
                            getWeatherAnimation(weather?.mainCondition),
                            fit: BoxFit.fitWidth),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
