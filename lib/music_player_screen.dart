import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'musica.dart';

class MusicPlayerScreen extends StatefulWidget {

  final Musica musica;

  MusicPlayerScreen({required this.musica, Key? key}) : super(key: key);


  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {

  final AudioPlayer audioPlayer = AudioPlayer();

  Future<void> playMusic() async {
    String musicaUrl = 'https://deezerdevs-deezer.p.rapidapi.com/track/${widget.musica.id}'; // Use widget.musica.id para obter a ID da música

    await audioPlayer.play(UrlSource(musicaUrl));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.musica.nome),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.musica.nome,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
            Text(widget.musica.artista,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            ),
            ElevatedButton(
              onPressed: playMusic,
              child: Text('Play'),
            ),
          ],
        ),
      ),
    );
  }
}
