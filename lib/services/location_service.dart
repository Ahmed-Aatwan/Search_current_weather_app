import 'package:dio/dio.dart';

class LocationService {
  final Dio _dio = Dio();
  final String _baseUrl = 'http://api.geonames.org';
  final String _username = 'aatwan';
  List<String> locations = []; // Replace with your GeoNames username

  Future<List<String>> fetchLocationSuggestions(
      {required String cityName}) async {
    if (cityName.isEmpty) {
      return [];
    } else {
      try {
        Response response = await _dio.get(
          '$_baseUrl/searchJSON',
          queryParameters: {
            'q': cityName,
            'maxRows': 10,
            'username': _username,
          },
        );
        Map<String, dynamic> jsonData = response.data;
        List<dynamic> geoNames = jsonData['geoNames'];
        for (var geoName in geoNames) {
          locations.add('City: ${geoName['name']}, Country: ${geoName['']}');
        }
        return locations;
      } on DioException {
        throw {'error fetching data'};
      } catch (e) {
        print('Error fetching location suggestions: $e');
        return [];
      }
    }
  }
}
