import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:webpageprac/model/movie_model.dart';

class MovieData {
  final String baseUrl = 'https://api.themoviedb.org/3/movie';
  final String bearerToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NmE3MWI2MzliYzY2ZDA1YjM2ZDJkOGU3MzVhNGMwZiIsIm5iZiI6MTcyOTY3OTc2OC44Mjg1NTgsInN1YiI6IjY3MThkMGM2MzRjMGZhYmQ2ODFjMjY4OSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.XEtxBjm5VH3AQ-a1QYhs4EsPFxG9Y1UDTPdN4kW7lyE';

  Future<List<MovieModel>> fetchTopRatedMovie() async {
    final response = await http
        .get(Uri.parse('$baseUrl/top_rated?language=en-US&page=1'), headers: {
      'Authorization': 'Bearer $bearerToken',
      'accept': 'application/json'
    });
    if (response.statusCode == 200) {

      return ((jsonDecode(response.body)['results']) as List)
          .map((e) => MovieModel.fromJson(e))
          .toList();
    } else {
      throw Exception("Failed to load movie data");
    }
  }

  Future<List<MovieModel>> fetchPopularMovies() async {
    final response = await http
        .get(Uri.parse('$baseUrl/popular?language=en-US&page=1'), headers: {
      'Authorization': 'Bearer $bearerToken',
      'accept': 'application/json'
    });
    if (response.statusCode == 200) {

      return ((jsonDecode(response.body)['results']) as List)
          .map((e) => MovieModel.fromJson(e))
          .toList();
    } else {
      throw Exception("Failed to load movie data");
    }
  }


  Future<List<MovieModel>> fetchNowPlayingMovies() async {
    final response = await http
        .get(Uri.parse('$baseUrl/now_playing?language=en-US&page=1'), headers: {
      'Authorization': 'Bearer $bearerToken',
      'accept': 'application/json'
    });
    if (response.statusCode == 200) {
      print('안되냐?');
      return ((jsonDecode(response.body)['results']) as List)
          .map((e) => MovieModel.fromJson(e))
          .toList();
    } else {
      throw Exception("Failed to load movie data");
    }
  }

  Future<List<MovieModel>> movieList() async {
    final response = await http.get(
        Uri.parse('https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc'),
        headers: {
          'Authorization': 'Bearer $bearerToken',
          'accept': 'application/json'
        }
    );

    if (response.statusCode == 200) {
      print(response.body);
      return ((jsonDecode(response.body)['results']) as List)
          .map((e) => MovieModel.fromJson(e)).toList();
    } else {
      print('영화 데이터 로드 실패: ${response.statusCode} ${response.body}');
      throw Exception("영화 데이터 로드 실패");
    }
  }


}