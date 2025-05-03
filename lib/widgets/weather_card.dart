import 'package:flutter/material.dart';
import '../models/weather_model.dart';

class WeatherCard extends StatelessWidget {
  final WeatherModel weather;

  const WeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              weather.cityName,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Image.network(
              weather.iconUrl,
              width: 64,
              height: 64,
            ),
            const SizedBox(height: 12),
            Text(
              '${weather.temperatureC} °C',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            Text(
              weather.condition,
              style: const TextStyle(fontSize: 16),
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Icon(Icons.water_drop_outlined),
                    const SizedBox(height: 4),
                    Text('${weather.humidity}%'),
                    const Text('Влажность', style: TextStyle(fontSize: 12)),
                  ],
                ),
                Column(
                  children: [
                    const Icon(Icons.air),
                    const SizedBox(height: 4),
                    Text('${weather.windKph} км/ч'),
                    const Text('Ветер', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
