import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  final List<dynamic> peliculas;

  CardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/img/loader.gif'),
              image: NetworkImage(
                  'https://i.pinimg.com/originals/d2/c6/55/d2c655de772a3468276005ebce4bff0b.jpg'),
              fit: BoxFit.cover,
            ),
          );
        },
        itemCount: peliculas.length,
        layout: SwiperLayout.STACK,
      ),
    );
  }
}
