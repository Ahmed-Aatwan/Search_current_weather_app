import 'package:dio/dio.dart';
import 'package:weather_search_app/models/weather_model.dart';

class WeatherService {
  final Dio _dio = Dio();
  final String _baseUrl = 'http://api.weatherapi.com/v1';
  final String _apiKey =
      'd1582e5583424374b18151530241605'; // Replace with your WeatherAPI key

  Future<List<String>> getLocationHints({required String query}) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/search.json',
        queryParameters: {
          'key': _apiKey,
          'q': query,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> locations = response.data;
        return locations.map((location) {
          // Format the suggestion as "City, Country"
          return '${location['name']}, ${location['country']}';
        }).toList();
      } else {
        throw Exception('Failed to load location hints');
      }
    } catch (e) {
      print('Error fetching location hints: $e');
      return [];
    }
  }

  Future<WeatherModel> getWeather({required String cityName}) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/forecast.json',
        queryParameters: {
          'key': _apiKey,
          'q': cityName,
          'days': '1',
        },
      );
      WeatherModel weatherModel = WeatherModel.fromJson(response.data);
      return weatherModel;
    } on DioException catch (e) {
      final String errorMessage =
          e.response?.data['error']['message'] ?? 'Error Loading Data';
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception({e.toString()});
    }
  }
}
