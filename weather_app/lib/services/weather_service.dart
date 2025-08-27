import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather.dart';

class WeatherService{
  final String _baseUrl= 'api.openweathermap.org';
  final String _path='/data/2.5/weather';
  final apiKey=const String.fromEnvironment('OWM_KEY',defaultValue: '');

  Future<Weather> getCurrentWeather(String city) async{
    try{
      final queryParameters={
        'q':city,
        'appid':apiKey,
        'units':'metric'
      };
      final uri =Uri.https(_baseUrl, _path, queryParameters);
      final response= await http.get(uri);
      if(response.statusCode==200){
        final jsonData=jsonDecode(response.body);
        return Weather.fromJson(jsonData);
      }else if(response.statusCode==401){
        print('Geçersiz API key!');
        throw Exception('Geçersiz API key!');
      } else if(response.statusCode==404){
        print('Şehir bulunamadı!');
        throw Exception('Şehir bulunamadı!');
      } else {
        print('Bilinmeyen bir hata oluştu: ${response.statusCode}');
        throw Exception('Bilinmeyen bir hata oluştu: ${response.statusCode}');
      }
    }catch(e){
      throw Exception("Hata oluştu: $e");
    }
  }
}