import 'dart:convert';
import 'dart:io';

import '../models/weather_model.dart';

class WeatherService {
  final String _apiKey =
      '555d2124bf1249b8b26194449250305';

  Future<WeatherModel?> fetchWeather(String city) async {
    try {
      final Uri url = Uri.parse(
        'https://api.weatherapi.com/v1/current.json?key=$_apiKey&q=$city&lang=ru',
      );

      final HttpClient httpClient = HttpClient();
      final HttpClientRequest request = await httpClient.getUrl(url);
      final HttpClientResponse response = await request.close().timeout(
        const Duration(seconds: 5),
      );

      if (response.statusCode == 200) {
        final String jsonString = await response.transform(utf8.decoder).join();
        final Map<String, dynamic> jsonData = json.decode(jsonString);
        return WeatherModel.fromJson(jsonData);
      } else {
        print('Request failed: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching weather: $e');

      try {
        print('Retrying...');
        final Uri retryUrl = Uri.parse(
          'https://api.weatherapi.com/v1/current.json?key=$_apiKey&q=$city&lang=ru',
        );

        final HttpClient retryClient = HttpClient();
        final HttpClientRequest retryRequest = await retryClient.getUrl(
          retryUrl,
        );
        final HttpClientResponse retryResponse = await retryRequest
            .close()
            .timeout(const Duration(seconds: 5));

        if (retryResponse.statusCode == 200) {
          final String retryJson =
              await retryResponse.transform(utf8.decoder).join();
          final Map<String, dynamic> retryData = json.decode(retryJson);
          return WeatherModel.fromJson(retryData);
        } else {
          print('Retry failed: ${retryResponse.statusCode}');
        }
      } catch (e2) {
        print('Retry exception: $e2');
      }

      return null;
    }
  }
}
