import 'package:flutter/material.dart';

import '../services/weather_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final weatherService = WeatherService();

  void fetchWeather() async {
    try {
      final weather = await weatherService.getCurrentWeather('Istanbul');
      print('Şehir: ${weather.city}');
      print('Sıcaklık: ${weather.temp} °C');
      print('Durum: ${weather.description}');
      print('Nem: ${weather.humidity}%');
    } catch (e) {
      print('Hata: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hava Durumu"),
      ),
    );
  }
}
