class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final double feelsLike;
  final double minTemp;
  final double maxTemp;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    required this.feelsLike,
    required this.minTemp,
    required this.maxTemp,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        cityName: json['name'],
        temperature: json['main']['temp'].toDouble(),
        mainCondition: json['weather'][0]['main'],
        feelsLike: json['main']['temp'].toDouble(),
        minTemp: json['main']['temp_min'].toDouble(),
        maxTemp: json['main']['temp_max'].toDouble());
  }
}
