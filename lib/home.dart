import 'dart:convert';

import 'package:app_music/musica_controller.dart';
import 'package:app_music/usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'editar_usuario.dart';
import 'favoritos.dart';
import 'music_player_screen.dart';
import 'musica.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var controller = MusicaController();
  String userName = '';
  String userEmail = '';

  @override
  void initState() {
    super.initState();

    // Carregue as músicas do Deezer ao iniciar a tela Home
    fetchDeezerMusic().then((musicas) {
      setState(() {
        // Atualize o estado com as músicas obtidas da API do Deezer
        controller.musicas = musicas;
      });
    });

    // Atualiza o nome e e-mail do usuário ao iniciar a tela Home
    updateUserDetails();
  }


  Future<List<Musica>> fetchDeezerMusic() async {
    final apiKey = '62bafc9fd3msh512fa4a06235479p1f2109jsn501a7d4b1771';
    final response = await http.get(
      Uri.parse('https://deezerdevs-deezer.p.rapidapi.com/playlist/%7Bid%7D'), // Substitua PLAYLIST_ID pelo ID da playlist desejada
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> tracks = data['tracks']['data'];

      List<Musica> musicas = tracks.map((track) => Musica(
        id: int.parse(track['id'].toString()),
        nome: track['title'],
        artista: track['artist']['name'],
      )).toList();

      return musicas;
    } else {
      throw Exception('Falha ao carregar músicas do Deezer');
    }
  }


  Future<void> updateUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userName = user.displayName ?? '';
        userEmail = user.email ?? '';

      });
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Navegue para a tela de login ou qualquer outra tela de entrada do aplicativo
      // Aqui, estamos navegando para a tela de login
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      print('Erro ao fazer logout: $e');
    }
  }

  @override
  Widget build(BuildContext context) {

    String userImageUrl = '';

    if (FirebaseAuth.instance.currentUser != null) {
      userImageUrl = FirebaseAuth.instance.currentUser!.photoURL ?? '';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  const Color(0xFF02d9de),
                  const Color(0xFF905ef1),
                  const Color(0xFFf902ff),
                ]
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                begin: Alignment.topLeft,
                  end: Alignment(0.8, 1),
                  colors: [
                    const Color(0xFF02d9de),
                    const Color(0xFF905ef1),
                    const Color(0xFFf902ff),
                  ],
                  tileMode: TileMode.mirror,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                  backgroundImage: userImageUrl != 'noImage'
                      ? NetworkImage(userImageUrl)
                      : Image.asset('imgs/user.png') as ImageProvider, // placeholder de imagem
              ),
              accountName: Text(userName,
                style: TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
              accountEmail: Text(userEmail,
                style: TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            ListTile(
              leading: ShaderMask( //Shader só funciona quando o Child possuir cor branca
                  shaderCallback: (Rect bounds) => LinearGradient(
                    colors: [
                      const Color(0xFF02d9de),
                      const Color(0xFF905ef1),
                      const Color(0xFFf902ff),
                    ],
                    tileMode: TileMode.mirror,
                  ).createShader(bounds),
                  child: Icon(
                    Icons.favorite,
                    color: Colors.white,
                  )
              ),
              title: Text("Músicas Curtidas",
                style: TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Favoritos(),
                  ),
                );
              },
            ),
            Container(
              height: 2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      const Color(0xFF02d9de),
                      const Color(0xFF905ef1),
                      const Color(0xFFf902ff),
                    ]
                ),
              ),
            ),
            ListTile(
              leading: ShaderMask( //Shader só funciona quando o Child possuir cor branca
                  shaderCallback: (Rect bounds) => LinearGradient(
                    colors: [
                      const Color(0xFF02d9de),
                      const Color(0xFF905ef1),
                      const Color(0xFFf902ff),
                    ],
                    tileMode: TileMode.mirror,
                  ).createShader(bounds),
                  child: Icon(
                    Icons.music_note,
                    color: Colors.white,
                  )
              ),
              title: Text("Playlist",
                style: TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
              onTap: (){
                Navigator.pop(context);
              },
            ),
            Container(
              height:2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      const Color(0xFF02d9de),
                      const Color(0xFF905ef1),
                      const Color(0xFFf902ff),
                    ]
                ),
              ),
            ),
            ListTile(
              leading: ShaderMask( //Shader só funciona quando o Child possuir cor branca
                  shaderCallback: (Rect bounds) => LinearGradient(
                    colors: [
                      const Color(0xFF02d9de),
                      const Color(0xFF905ef1),
                      const Color(0xFFf902ff),
                    ],
                    tileMode: TileMode.mirror,
                  ).createShader(bounds),
                  child: Icon(
                    Icons.account_circle,
                    color: Colors.white,
                  )
              ),
              title: Text("Editar Perfil",
                style: TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditarUsuario(usuario: Usuario(nome: userName, email: userEmail, senha: '')),
                  ),
                );
              },

            ),
            Container(
              height:2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      const Color(0xFF02d9de),
                      const Color(0xFF905ef1),
                      const Color(0xFFf902ff),
                    ]
                ),
              ),
            ),
            ListTile(
              leading: ShaderMask( //Shader só funciona quando o Child possuir cor branca
                  shaderCallback: (Rect bounds) => LinearGradient(
                    colors: [
                      const Color(0xFF02d9de),
                      const Color(0xFF905ef1),
                      const Color(0xFFf902ff),
                    ],
                    tileMode: TileMode.mirror,
                  ).createShader(bounds),
                  child: Icon(
                    Icons.logout,
                    color: Colors.white,
                  )
              ),
              title: Text("Logoff",
                style: TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
              onTap: () {
                signOut(); // Chame a função para deslogar
              },
            ),
            Container(
              height:2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      const Color(0xFF02d9de),
                      const Color(0xFF905ef1),
                      const Color(0xFFf902ff),
                    ]
                ),
              ),
            ),
            ListTile(
              leading: ShaderMask( //Shader só funciona quando o Child possuir cor branca
                  shaderCallback: (Rect bounds) => LinearGradient(
                    colors: [
                      const Color(0xFF02d9de),
                      const Color(0xFF905ef1),
                      const Color(0xFFf902ff),
                    ],
                    tileMode: TileMode.mirror,
                  ).createShader(bounds),
                  child: Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  )
              ),
              title: Text("Sair",
                style: TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
              onTap: () {
                SystemNavigator.pop(); // Chame a função para deslogar
              },
            ),
          ],
        )
      ),
      body: ListView.builder(
        padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
        itemCount: controller.musicas.isNotEmpty ? controller.musicas.length * 2 - 1 : 0,
        itemBuilder: (context, i){

          if(i.isOdd){
            return DividerGradient();
          }

          final musica = controller.musicas[i];
          final itemIndex = i ~/2;
          return Container(
            padding: EdgeInsets.only(top: 4, bottom: 4),
            child: ListTile(
              style: ListTileStyle.list,
              leading: CircleAvatar(
                backgroundColor: Colors.grey[300],
                radius: 30,
              ),
              title: Text(musica.nome,
                style: TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
              subtitle: Text(musica.artista,
                style: TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
              trailing: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ShaderMask( //Shader só funciona quando o Child possuir cor branca
                      shaderCallback: (Rect bounds) => LinearGradient(
                        colors: [
                          const Color(0xFF02d9de),
                          const Color(0xFF905ef1),
                          const Color(0xFFf902ff),
                        ],
                        tileMode: TileMode.mirror,
                      ).createShader(bounds),
                      child: Icon(
                        Icons.favorite,
                        color: Colors.white,
                      )
                  ),
                  ShaderMask( //Shader só funciona quando o Child possuir cor branca
                      shaderCallback: (Rect bounds) => LinearGradient(
                        colors: [
                          const Color(0xFF02d9de),
                          const Color(0xFF905ef1),
                          const Color(0xFFf902ff),
                        ],
                        tileMode: TileMode.mirror,
                      ).createShader(bounds),
                      child: IconButton(
                        icon: Icon(
                          Icons.play_circle,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MusicPlayerScreen(musica: musica),
                            ),
                          );
                        },
                      )
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


class DividerGradient extends StatelessWidget {
  const DividerGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          width: double.infinity,
          height: 2,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  const Color(0xFF02d9de),
                  const Color(0xFF905ef1),
                  const Color(0xFFf902ff),
                ]
            ),
          ),
        ),
      ),
    );
  }
}
