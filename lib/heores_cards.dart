import 'package:flutter/material.dart';
import 'package:mapeo_json_marvel/main.dart';

class ShowCard extends StatelessWidget {
  final heroesMarvel heroes;

  ShowCard(this.heroes);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lime,
        centerTitle: true,
        title: Text(heroes.superheroe.toString().toUpperCase()),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Center(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(heroes.image)),
                      ),
                    ),
                    Center(
                      child: new Text(
                        heroes.identidad,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    Text(""),
                    Center(child: Text("EDAD: " + heroes.edad)),
                    Text(""),
                    Center(child: Text("ALTURA: " + heroes.altura)),
                    Text(""),
                    Center(child: Text("GENERO: " + heroes.genero)),
                    Text(""),
                    Center(child: Text("DESCRIPCIÓN GENERAL: ")),
                    Text(""),
                    Text(heroes.descripcion)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}