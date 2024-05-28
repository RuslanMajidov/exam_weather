// weather_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = '6f113c0b8ac8d863206b6cf6cb7c3e8b';
  final double latitude = 55.0;
  final double longitude = -3.0;

  Future<Map<String, dynamic>> fetchWeatherData() async {
    final String url =
        'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
