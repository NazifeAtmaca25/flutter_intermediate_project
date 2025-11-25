import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../model/movie.dart';
import 'package:http/http.dart' as http;
class TmdbApi{
  final String _apiKey=dotenv.env['TMDB_API_KEY'] ?? "";
  final String _baseUrl="https://api.themoviedb.org/3";

  Future<List<Movie>> getPopularMovies() async{
    final url= Uri.parse("$_baseUrl/movie/popular?api_key=$_apiKey&language=en-US&page=1");
    try{
      final response= await http.get(url);
      if(response.statusCode==200){
        final data= jsonDecode(response.body);
        final List result=data["results"];

        List<Movie> movies=result.map((json)=>Movie.fromJson(json)).toList();
        print("-------------------------------------------------------------------------------");
        print(movies[1]);
        return movies;
      } else{
        throw Exception("getPopulerMovies Veri Çekilemedi. Hata Kodu: ${response.statusCode}");
      }
    } catch (e){
      throw Exception("getPopulerMovies hata oluştu: $e");
    }
  }

  Future<List<Movie>> searchMovie(String movieName) async{
    final url = Uri.parse("$_baseUrl/search/movie?api_key=$_apiKey&query=$movieName&language=en-US&page=1");
    try{
      final response= await http.get(url);
      if(response.statusCode==200){
        final data= jsonDecode(response.body);
        final List result=data["results"];

        List<Movie> movies=result.map((json)=>Movie.fromJson(json)).toList();
        print("*****************************");
        return movies;
      } else{
        throw Exception("searchMovie Veri Çekilemedi. Hata Kodu: ${response.statusCode}");
      }
    } catch(e){
      throw Exception("searchMovie hata oluştu: $e");
    }
  }


}