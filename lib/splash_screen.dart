import 'package:flutter/material.dart';
import 'package:mapeo_json_marvel/main.dart';
import 'package:splashscreen/splashscreen.dart';


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SplashScreen(
        title: Text(
          "Cargando...",
          style: TextStyle(
              fontWeight: FontWeight.normal, fontSize: 25, color: Colors.white),
        ),
        photoSize: 150,
        seconds: 5,
        backgroundColor: Colors.blueGrey,
        image: Image.network(
            'https://lh3.googleusercontent.com/proxy/OqX6x7gxQo_ygDkUJV3dFW4z0wDKmTlh_FXAnmJf_kN7E7E_GBYECIJQSyydgZb_DuZRxBjIgrEgySJCwDidU-B0S86e7-vRR3yg3iIN_5rqJapraZk'),
        navigateAfterSeconds: HomePage());
  }
}