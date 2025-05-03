class WeatherModel {
  final String cityName;
  final String condition;
  final String iconUrl;
  final double temperatureC;
  final double windKph;
  final int humidity;

  WeatherModel({
    required this.cityName,
    required this.condition,
    required this.iconUrl,
    required this.temperatureC,
    required this.windKph,
    required this.humidity,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['location']['name'],
      condition: json['current']['condition']['text'],
      iconUrl: 'https:${json['current']['condition']['icon']}',
      temperatureC: json['current']['temp_c'].toDouble(),
      windKph: json['current']['wind_kph'].toDouble(),
      humidity: json['current']['humidity'],
    );
  }
}
