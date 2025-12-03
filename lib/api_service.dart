import 'dart:convert';
import 'package:http/http.dart' as http;

import 'movie.dart';

class ApiService {
  static const String _url =
      'https://mocki.io/v1/00e3f2c7-e43b-444f-b34f-9551c369bc8e';

  static Future<List<Movie>> fetchMovies() async {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Erreur API (code: ${response.statusCode})');
    }
  }
}
