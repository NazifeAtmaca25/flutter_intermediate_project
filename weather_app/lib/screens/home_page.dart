import 'package:flutter/material.dart';
import 'package:weather_app/models/weather.dart';

import '../services/weather_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final weatherService = WeatherService();
  List<String> cities=[
    'Istanbul',
    'Ankara',
    'Izmir',
    'Bursa',
    'Antalya',
    'Adana',
    'Konya',
    'Gaziantep',
    'Kayseri',
    'Mersin',
    'Denizli'];

  String _selectedCity='Istanbul';
  Weather? _weather;

  void fetchWeather() async {
    try {
      final weather = await weatherService.getCurrentWeather(_selectedCity);
      setState(() {
        _weather=weather;
      });
    } catch (e) {
      print('Hata: $e');
    }
  }

  Color _getBackgroundColor(String description){
    if(description.contains('rain')){
      return Colors.blueGrey.shade600;
    }else if (description.contains("cloud")) {
      return Colors.blueGrey.shade200;
    } else if (description.contains("clear")) {
      return Colors.orange.shade200;
    } else if (description.contains("snow")) {
      return Colors.blue.shade100;
    }
    return Colors.lightBlue.shade200;
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _weather==null ? Colors.blue[100] :_getBackgroundColor(_weather!.description.toLowerCase()),
      appBar: AppBar(
        title: Text("Hava Durumu",style: TextStyle(fontSize: 30),),
        centerTitle: true,
        foregroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(colors: [
              Colors.blue,
              Colors.grey,
              Colors.white
            ], center: Alignment.center,
            radius: 13)
          ),
        ),
      ),
      body: Padding(padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField(
            value: _selectedCity,
              decoration: InputDecoration(
                labelText: "Şehir Seç",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.blue[50]
              ),
              items: cities.map((city){
            return DropdownMenuItem(value:city,child: Text(city));
          }).toList(),
              onChanged: (value){
                if(value != null){
                  setState(() {
                    _selectedCity=value;
                  });
                  fetchWeather();
                }
              }),
          SizedBox(height:16 ,),
          _weather==null
             ? CircularProgressIndicator()
              :Card(
                elevation: 6,
                color: Colors.blue[50],
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                  Text(_weather!.city.replaceAll(" Province", " "),style: TextStyle(fontSize: 30),),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      Image.network(
                          "http://openweathermap.org/img/wn/${_weather!.icon}@2x.png",
                      height: 80,
                      width: 80,),
                      SizedBox(width: 15,),
                      Text("${_weather!.temp.toStringAsFixed(1)}°C",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Text("Hissedilen: ${_weather!.feelsLike.toStringAsFixed(1)}°C",style: TextStyle(fontSize: 20),),
                  Text("Min/Max: ${_weather!.tempMin.toStringAsFixed(1)}°C /${_weather!.tempMax.toStringAsFixed(1)}°C",style: TextStyle(fontSize: 20)),
                  Text("Nem: ${_weather!.humidity.toString()}%",style: TextStyle(fontSize: 20))
                              ],
                            ),
                ),
              )
        ],
      ),),
    );
  }
}
