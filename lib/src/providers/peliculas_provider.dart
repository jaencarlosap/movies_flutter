import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:movies/src/models/pelicula_model.dart';

class PelicuasProvider {
  String _apiKey = '857e863d16d83ff461f8d169c6ad9a7b';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final response = await http.get(url);
    final decodeData = json.decode(response.body);

    final peliculas = Peliculas.fromJsonList(decodeData['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
    });

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
    });

    return await _procesarRespuesta(url);
  }
}
