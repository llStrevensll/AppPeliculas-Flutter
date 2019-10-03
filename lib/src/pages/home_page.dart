import 'package:flutter/material.dart';

import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/search/search_delegate.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {

  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    
    peliculasProvider.getPopulares();
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Titulo App'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(//metodo de busqueda en flutter
                context: context, 
                delegate: DataSearch(),
                //query: 'Hola'
              );
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTarjetas(),
            _footer(context)
          ] 
        ),
      ),  
    );
  }

  Widget _swiperTarjetas(){

    return FutureBuilder(
      future: peliculasProvider.getEnCines(),//obtener listado de peliculas en cine
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

        if (snapshot.hasData) {
          return CardSwiper(peliculas: snapshot.data);//envia la lista de peliculas a CardSwiper para visualizar en el app
        }else{
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator(),//animacion circulo de carga
            ),
          );
        }

      },
    );

  }

  Widget _footer(BuildContext context){
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text('Populares', style: Theme.of(context).textTheme.subhead,)//theme global
          ),
          SizedBox(height: 5.0),
          StreamBuilder(
            stream: peliculasProvider.pupularesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              //snapshot.data?.forEach((p) => print(p.title));
              if (snapshot.hasData) {
                return MovieHorizontal(
                  peliculas: snapshot.data,
                  siguientePagina: peliculasProvider.getPopulares,
                );
              }else{
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );

  }
}