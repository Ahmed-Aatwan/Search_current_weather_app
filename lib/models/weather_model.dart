class WeatherModel {
  final String cityName;
  final String? currentWeatherCondition;
  final String? forecastWeatherCondition;
  final double maxTemp;
  final double minTemp;
  final double currentTemp;
  final String? currentWeatherConditionImage;
  final String? forecastWeatherConditionImage;
  final DateTime lastUpdated;
  WeatherModel({
    required this.cityName,
    required this.currentWeatherCondition,
    required this.forecastWeatherCondition,
    required this.maxTemp,
    required this.minTemp,
    required this.currentTemp,
    required this.currentWeatherConditionImage,
    required this.lastUpdated,
    this.forecastWeatherConditionImage,
  });
  factory WeatherModel.fromJson(dynamic json) => WeatherModel(
    cityName: json['location']['name'] ?? '',
    currentWeatherCondition: json['current']['condition']['text'] ?? '',
    forecastWeatherCondition:
        json['forecast']['forecastday'][0]['day']['condition']['text'] ?? ' ',
    maxTemp:
        json['forecast']['forecastday'][0]['day']['maxtemp_c']?.toDouble() ??
        0.0,
    minTemp:
        json['forecast']['forecastday'][0]['day']['mintemp_c']?.toDouble() ??
        0.0,
    currentTemp: json['current']['temp_c'].toDouble() ?? 0.0,
    currentWeatherConditionImage: json['current']['condition']['icon'] != null
        ? 'https:${json['current']['condition']['icon']}'
        : '',
    forecastWeatherConditionImage:
        json['forecast']['forecastday'][0]['day']['condition']['icon'] != null
        ? 'https:${json['forecast']['forecastday'][0]['day']['condition']['icon']}'
        : '',
    lastUpdated: DateTime.parse(json['current']['last_updated']),
  );
}
