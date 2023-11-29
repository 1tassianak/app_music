import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MusicPlayerScreen extends StatefulWidget {
  final dynamic musica;

  MusicPlayerScreen({required this.musica});

  @override
  _MusicPlayerScreenState createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {

  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    // Reproduza a música quando a tela MusicPlayerScreen é iniciada
    _playMusic();
  }

  Future<void> _playMusic() async {
    final String? url = widget.musica['https://open.spotify.com/artist/3t8WiyalpvnB9AObcMufiE'];

    if (url != null) {
      await audioPlayer.play(UrlSource(url));
    } else {
      // Lide com o cenário em que a URL da música está faltando
      // Exiba uma mensagem de erro, retorne à tela anterior, ou faça qualquer outra ação apropriada.
    }
  }


  @override
  void dispose() {
    audioPlayer.stop();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Now Playing"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.musica['nome'],
              style: TextStyle(fontSize: 20),
            ),
            Text(
              widget.musica['artista'],
              style: TextStyle(fontSize: 16),
            ),
            // Adicione controles de reprodução ou informações adicionais da música, conforme necessário
          ],
        ),
      ),
    );
  }
}
