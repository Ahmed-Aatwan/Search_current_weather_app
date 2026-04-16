import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  static String baseUrl = 'https://api.weatherapi.com/v1';
  static String apiKey = 'd1582e5583424374b18151530241605';
  final dio = Dio();

  Future<WeatherModel> getWeatherForecast({required String cityName}) async {
    try {
      final response = await dio.get(
        '$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=1',
      );
      WeatherModel weather = WeatherModel.fromJson(response.data);
      return weather;
    } on DioException catch (e) {
      final String errMsg =
          e.response?.data['error']['message'] ?? 'error, try later';
      throw Exception(errMsg);
    } catch (e) {
      log(e.toString());
      throw Exception('error, try later');
    }
  }
}
