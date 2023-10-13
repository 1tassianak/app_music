import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'cadastro.dart';
import 'intro.dart';
import 'login.dart';

Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();

  //espera o Firebase inicializar
  await Firebase.initializeApp();

  FirebaseFirestore.instance.collection('usuarios').doc('alunos').set({'Nome': 'Tassiana', 'Sobrenome': 'Kautzmann'});

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
