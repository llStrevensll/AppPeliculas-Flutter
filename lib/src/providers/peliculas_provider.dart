import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/models/actores_model.dart';

class PeliculasProvider {
  
  String _apikey   = 'fc97f4579bd981d43e5115ffb9aac53a';
  String _url      = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularesPage = 0;
  bool _cargando     = false;
  List<Pelicula> _populares = new List();//lista de peliculas polulares

  //Stream de peliculas polulares
  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();//broadcast todos escuchan el stream

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add; //sink ->entrada

  Stream<List<Pelicula>> get pupularesStream => _popularesStreamController.stream;//stream ->escuchar(salida)


  void disposeStreams(){
    _popularesStreamController?.close();
  }


  //Respuesta al realizar una peticion 
  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);//respuesta de obtener peliculas en cine
    final decodedData = json.decode(resp.body);//decodificar json -> visualizar como mapa

    final peliculas = new Peliculas.fromJsonList(decodedData['results']);//Envia al metodo de models pelicula , la lista dinamica
    
    //print(peliculas.items[0].title);
    return peliculas.items;
  }

  //Peliculas en cine
  Future<List<Pelicula>> getEnCines() async{

    //Realizar el url
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key' : _apikey,
      'language' : _language
    });
    
    return await _procesarRespuesta(url);
  }

  //Peliculas Polulares
  Future<List<Pelicula>> getPopulares() async{
    if (_cargando) return[];//si esta cargando, no hace nada (espera)
    
    //primera ocasion _cargando es false por ello se asigna true
    _cargando = true;
    _popularesPage++;

    //Realizar el url
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key'   : _apikey,
      'language'  : _language,
      'page'      : _popularesPage.toString()
    });
    
    final resp = await _procesarRespuesta(url);
    _populares.addAll(resp);//adicionar toda la lista de peliculas populares

    popularesSink(_populares);//entrada-añadir informacion al stream mediante el sink
    
    _cargando = false;  
    return resp;
  }

  //Actores de la pelicula
  Future<List<Actor>> getCast(String peliId) async{

    final url = Uri.https(_url, '3/movie/$peliId/credits', {
      'api_key'   : _apikey,
      'language'  : _language,
    });

    final resp = await http.get(url);//respuesta http
    final decodedData = json.decode(resp.body);

    final cast = new Cast.fromJsonList(decodedData['cast']);//Actores model

    return cast.actores;
  }

  //Peliculas en cine
  Future<List<Pelicula>> buscarPelicula(String query) async{

    final url = Uri.https(_url, '3/search/movie', {
      'api_key'   : _apikey,
      'language'  : _language,
      'query'     : query
    });
    
    return await _procesarRespuesta(url);
  }
}