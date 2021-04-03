import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

import 'package:movies/src/models/pelicula_model.dart';
import 'package:movies/src/models/actores_model.dart';

class PeliculasProvider {
  String _apiKey = '857e863d16d83ff461f8d169c6ad9a7b';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularesPage = 0;
  bool _loading = false;

  List<Pelicula> _populares = [];

  //crea stream
  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  // crea set en stream
  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;

  // crea get de stream
  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  void disposeStreams() {
    _popularesStreamController?.close(); // destruye el stream
  }

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
    if (_loading) return [];
    _loading = true;

    _popularesPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularesPage.toString(),
    });

    final response = await _procesarRespuesta(url);

    //se añada info al stream
    _populares.addAll(response);
    popularesSink(_populares);

    _loading = false;

    return response;
  }

  Future<List<Actor>> getCast(String peliId) async {
    final url = Uri.https(_url, '3/movie/$peliId/credits', {
      'api_key': _apiKey,
      'language': _language,
    });

    final response = await http.get(url);
    final decodeData = json.decode(response.body);

    final cast = Cast.fromJsonList(decodeData['cast']);

    return cast.actores;
  }

  Future<List<Pelicula>> buscarPelicula(String query) async {
    final url = Uri.https(_url, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query,
    });

    return await _procesarRespuesta(url);
  }
}
