import 'package:weather_app/models/weather_model.dart';

class NoWeatherState extends WeatherStates {}

class WeatherFailedLoadingState extends WeatherStates {}

class WeatherLoadedState extends WeatherStates {
  final WeatherModel weatherModel;

  WeatherLoadedState({required this.weatherModel});
}

class WeatherLoadingState extends WeatherStates {}

class WeatherStates {}
