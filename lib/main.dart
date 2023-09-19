import 'package:flutter/material.dart';

import 'cadastro.dart';
import 'intro.dart';
import 'login.dart';

void main() {
  runApp(MaterialApp(
    title: "MusicApp",
    home: Intro(),
    debugShowCheckedModeBanner: false,

    //Rotas nomeadas
    routes: {
      '/login': (context) => Login(),
    },
  ));
}
