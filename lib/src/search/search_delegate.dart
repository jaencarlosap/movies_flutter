import 'package:flutter/material.dart';

import 'package:movies/src/models/pelicula_model.dart';

import 'package:movies/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {
  String seleccion = '';

  final peliculasProvider = PeliculasProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    //Acciones del AppBar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del AppBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // crea los resultados a mostrar
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //crea las sugerencias al usuario mientras escribe
    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: snapshot.data
                .map(
                  (pelicula) => ListTile(
                    leading: FadeInImage(
                      placeholder: AssetImage('assets/img/no-image.jpg'),
                      image: NetworkImage(pelicula.getPosterImg()),
                      width: 50.0,
                      fit: BoxFit.cover,
                    ),
                    title: Text(pelicula.title),
                    subtitle: Text(pelicula.originalTitle),
                    onTap: () {
                      close(context, null);
                      pelicula.uniqueId = '';
                      Navigator.pushNamed(context, 'detalle',
                          arguments: pelicula);
                    },
                  ),
                )
                .toList(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
