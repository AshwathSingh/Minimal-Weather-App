// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:minimal_weather_app/models/weather_model.dart';
import 'package:minimal_weather_app/pages/others_page.dart';
import 'package:minimal_weather_app/services/weather_services.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => WeatherPageState();
}

class WeatherPageState extends State<WeatherPage>
    with SingleTickerProviderStateMixin {
  late final TabController pageController;

  final _weatherService = WeatherService('7f16949fdfa98b2cb71bfe4b57c34ac9');

  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 19) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  Color? topColor() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return Colors.amberAccent[200];
    }
    if (hour < 17) {
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
    _fetchWeather();
    pageController = TabController(
        length: 2, vsync: this, animationDuration: Duration(seconds: 1));
  }

  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: TabBarView(
        controller: pageController,
        children: [
          Padding(
            padding:
                const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
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
                      decoration:
                          const BoxDecoration(color: Colors.transparent),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '📍 ${_weather?.cityName}',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          greeting(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 25),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Lottie.asset(
                              getWeatherAnimation(_weather?.mainCondition),
                              fit: BoxFit.fitWidth),
                        ),
                        Center(
                          child: Text(
                            'feels like ${_weather?.feelsLike.round()}°',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            '${_weather?.temperature.round()}°',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 45,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            '${_weather?.mainCondition}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 35,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Image.asset(
                                'assets/13.png',
                                scale: 8,
                              ),
                              const SizedBox(width: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Maximum',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    "${_weather?.maxTemp.round()}°",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              )
                            ]),
                            Row(children: [
                              Image.asset(
                                'assets/14.png',
                                scale: 8,
                              ),
                              const SizedBox(width: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Minimum',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 0),
                                  Text(
                                    '${_weather?.minTemp.round()}°',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              )
                            ])
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          OtherPage(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(200),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: AnimatedBuilder(
              animation: pageController,
              builder: (context, _) {
                return NavigationBar(
                  indicatorShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(200),
                  ),
                  backgroundColor: Colors.black26,
                  indicatorColor: Colors.transparent,
                  selectedIndex: pageController.index,
                  labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                  onDestinationSelected: (index) {
                    pageController.animateTo(index);
                  },
                  destinations: [
                    NavigationDestination(
                      icon: Icon(
                        Icons.pin_drop_outlined,
                        color: Colors.white,
                      ),
                      selectedIcon: Icon(
                        Icons.pin_drop,
                        color: Colors.white,
                      ),
                      label: "Home",
                    ),
                    NavigationDestination(
                      icon: Icon(
                        Icons.bookmark_border_rounded,
                        color: Colors.white,
                      ),
                      selectedIcon: Icon(
                        Icons.bookmark,
                        color: Colors.white,
                      ),
                      label: 'Other',
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
