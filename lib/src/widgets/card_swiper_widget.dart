import 'package:flutter/material.dart';


import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {

  final List<Pelicula> peliculas;

  CardSwiper({@required this.peliculas});//obligatorio -> required

  @override
  Widget build(BuildContext context) {
      
    final _screenSize = MediaQuery.of(context).size;
  
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      //width: double.infinity,//todo el ancho posible
      //height: 300.0,
      child: Swiper(
          layout: SwiperLayout.STACK,//forma de stack
          itemWidth: _screenSize.width * 0.7,
          itemHeight: _screenSize.height * 0.5,
          itemBuilder: (BuildContext context, int index){//realiza ciclo con cada elemento
            // return ClipRRect(
            //   borderRadius: BorderRadius.circular(20.0),
            //   child: Image.network(,fit: BoxFit.fill,),
            // );

            peliculas[index].uniqueId = '${peliculas[index].id}-tarjeta';//concatenar al id la palabra tarjeta
            
            return Hero(
              tag: peliculas[index].uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: GestureDetector(
                  onTap: ()=> Navigator.pushNamed(context, 'detalle', arguments: peliculas[index]),
                  child: FadeInImage(
                    image: NetworkImage(peliculas[index].getPosterImg()),//imagen del poster
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
          itemCount: peliculas.length,
          //pagination: new SwiperPagination(),
          //control: new SwiperControl(),
        ),
    );

  }
}