import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_search_app/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:weather_search_app/models/weather_model.dart';
import 'package:weather_search_app/services/weather_service.dart';

class GetWeatherStatesCubit extends Cubit<WeatherState> {
  GetWeatherStatesCubit() : super(WeatherInitialState());
  WeatherModel? weatherModel;
  getWeather({required String cityName}) async {
    try {
      weatherModel = await WeatherService().getWeather(cityName: cityName);
      emit(
        WeatherLoadedSuccessfullyState(
          weatherModel: weatherModel!,
        ),
      );
    } on Exception catch (e) {
      emit(
        WeatherFailedLoadingState(
          errMessage: e.toString(),
        ),
      );
    }
  }
}
