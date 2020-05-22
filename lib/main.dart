import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:mapeo_json_marvel/heores_cards.dart';
import 'package:mapeo_json_marvel/splash_screen.dart';
import 'package:getflutter/getflutter.dart';

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
    theme: ThemeData.dark(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomePage extends StatefulWidget {
  @override
  homePageState createState() => new homePageState();
}

class homePageState extends State<HomePage> {
  Future<String> _loadAsset() async {
    return await rootBundle.loadString('json_marvel/json_.json');
  }

  Future<List<heroesMarvel>> _getHeroes() async {
    String jsonString = await _loadAsset();
    var jsonData = jsonDecode(jsonString);

    List<heroesMarvel> heroes = [];
    for (var i in jsonData) {
      heroesMarvel he = heroesMarvel(i["image"], i["superheroe"], i["identidad"],
          i["edad"], i["altura"], i["genero"], i["descripcion"]);
      heroes.add(he);
    }
    return heroes;
  }

  String searchString = "";
  bool _isSearching = false;
  final searchController = TextEditingController();

  AudioPlayer audioPlayer;
  AudioCache audioCache;

  final audioname = "audio_heroes.mp3";

  @override
  void initState() {
    super.initState();

    audioPlayer = AudioPlayer();
    audioCache = AudioCache();
    var loop = 1;

    setState(() {
      audioCache.play(audioname);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lime,
        centerTitle: true,
        title: _isSearching
            ? TextField(
          decoration: InputDecoration(
              hintText: "Busca un superheroe",
              icon: Icon(Icons.search)),
          onChanged: (value) {
            setState(() {
              searchString = value;
            });
          },
          controller: searchController,
        )
            : Text("Superhéroes"),
        actions: <Widget>[
          !_isSearching
              ? IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                searchString = "";
                this._isSearching = !this._isSearching;
              });
            },
          )
              : IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              setState(() {
                this._isSearching = !this._isSearching;
              });
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          child: FutureBuilder(
            future: _getHeroes(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text("Cargando..."),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return snapshot.data[index].superheroe
                        .contains(searchString)
                        ? ListTile(
                      leading: GFAvatar(
                        backgroundImage: NetworkImage(
                            snapshot.data[index].image.toString()),
                          shape: GFAvatarShape.standard
                      ),
                      title: Text(snapshot.data[index].superheroe
                          .toString()
                          .toUpperCase()),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShowCard(
                                    snapshot.data[index])));
                      },
                    )
                        : Container();
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class heroesMarvel {
  final String image;
  final String superheroe;
  final String identidad;
  final String edad;
  final String altura;
  final String genero;
  final String descripcion;

  heroesMarvel(this.image, this.superheroe, this.identidad, this.edad,
      this.altura, this.genero, this.descripcion);
}