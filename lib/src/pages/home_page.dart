import 'package:flutter/material.dart';

import 'package:movies/src/widgets/card_swiper_widget.dart';
import 'package:movies/src/widgets/movie_horizontal.dart';

import 'package:movies/src/providers/peliculas_provider.dart';

class HomaPage extends StatelessWidget {
  final peliculasProvider = PelicuasProvider();

  @override
  Widget build(BuildContext context) {
    peliculasProvider.getPopulares();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Peliculas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _swiperTarjetas(),
            _footer(context),
          ],
        ),
      ),
    );
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(peliculas: snapshot.data);
        } else {
          return Container(
            height: 400.0,
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 10.0, left: 15.0),
            child: Text(
              'Populares',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(
                  peliculas: snapshot.data,
                  nextPage: peliculasProvider.getPopulares,
                );
              } else {
                return Container(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
