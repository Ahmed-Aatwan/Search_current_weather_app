import 'package:weather_search_app/models/weather_model.dart';

class WeatherState {}

class WeatherLoadedSuccessfullyState extends WeatherState {
  final WeatherModel weatherModel;

  WeatherLoadedSuccessfullyState({required this.weatherModel});
}

class WeatherFailedLoadingState extends WeatherState {
  final String errMessage;

  WeatherFailedLoadingState({required this.errMessage});
}

class WeatherInitialState extends WeatherState {}
