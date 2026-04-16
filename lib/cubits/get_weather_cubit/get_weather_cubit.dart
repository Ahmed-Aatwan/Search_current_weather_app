import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class GetWeatherCubit extends Cubit<WeatherStates> {
  WeatherModel? weather;
  GetWeatherCubit() : super(NoWeatherState());
  Future<void> getWeather({required String cityName}) async {
    emit(WeatherLoadingState());
    try {
      WeatherModel weatherModel = await WeatherService().getWeatherForecast(
        cityName: cityName,
      );
      weather = weatherModel;
      emit(WeatherLoadedState(weatherModel: weatherModel));
    } on Exception catch (e) {
      log(e.toString());
      emit(WeatherFailedLoadingState());
    }
  }
}
