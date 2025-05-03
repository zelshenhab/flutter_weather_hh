import 'dart:async';
import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';
import '../widgets/weather_card.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _cityController = TextEditingController(
    text: 'Омск',
  );
  final WeatherService _weatherService = WeatherService();

  WeatherModel? _weather;
  bool _isLoading = false;
  Timer? _timer;

  Future<void> _getWeather() async {
    setState(() => _isLoading = true);

    final weather = await _weatherService.fetchWeather(
      _cityController.text.trim(),
    );

    setState(() {
      _weather = weather;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getWeather();

    _timer = Timer.periodic(const Duration(hours: 1), (timer) {
      _getWeather();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Погода'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                hintText: 'Введите город',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _getWeather,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (_isLoading)
              const CircularProgressIndicator()
            else if (_weather != null)
              WeatherCard(weather: _weather!)
            else
              const Text('Введите город и нажмите поиск'),
          ],
        ),
      ),
    );
  }
}
