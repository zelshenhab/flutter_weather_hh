import 'dart:convert';
import 'dart:io';

import '../models/weather_model.dart';

class WeatherService {
  final String _apiKey =
      '555d2124bf1249b8b26194449250305'; // ← ضع مفتاح API الخاص بك هنا

  Future<WeatherModel?> fetchWeather(String city) async {
    try {
      final url = Uri.parse(
        'https://api.weatherapi.com/v1/current.json?key=$_apiKey&q=$city&lang=ru',
      );

      final HttpClient httpClient = HttpClient();
      final HttpClientRequest request = await httpClient.getUrl(url);
      final HttpClientResponse response = await request.close();

      if (response.statusCode == 200) {
        final String jsonString = await response.transform(utf8.decoder).join();
        final Map<String, dynamic> jsonData = json.decode(jsonString);
        return WeatherModel.fromJson(jsonData);
      } else {
        print('Failed to load weather data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching weather: $e');
      return null;
    }
  }
}
