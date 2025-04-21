class WeatherModel {
  final String cityName, image, weatherConditon;
  final DateTime time;
  final double avgTemp, maxTemp, minTemp;

  WeatherModel({
    required this.cityName,
    required this.image,
    required this.weatherConditon,
    required this.time,
    required this.avgTemp,
    required this.maxTemp,
    required this.minTemp,
  });
  factory WeatherModel.fromJson(json) {
    return WeatherModel(
      cityName: json['location']['name'],
      image:
          'https:${json['forecast']['forecastday'][0]['day']['condition']['icon']}',
      weatherConditon: json['forecast']['forecastday'][0]['day']['condition']
          ['text'],
      time: DateTime.parse(
        json['current']['last_updated'],
      ),
      avgTemp: json['forecast']['forecastday'][0]['day']['avgtemp_c'],
      maxTemp: json['forecast']['forecastday'][0]['day']['maxtemp_c'],
      minTemp: json['forecast']['forecastday'][0]['day']['mintemp_c'],
    );
  }
}
