import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

class HomaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          children: [
            _swiperTarjetas(),
          ],
        ),
      ),
    );
  }

  Widget _swiperTarjetas() {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      width: double.infinity,
      height: 300.0,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            "http://via.placeholder.com/350x150",
            fit: BoxFit.fill,
          );
        },
        itemCount: 3,
        itemWidth: 200.0,
        layout: SwiperLayout.STACK,
      ),
    );
  }
}
