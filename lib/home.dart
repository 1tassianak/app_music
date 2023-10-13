import 'package:app_music/musica_controller.dart';
import 'package:flutter/material.dart';

import 'favoritos.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var controller = MusicaController();

  @override
  Widget build(BuildContext context) {
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
                  backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRws9oxLyyfsQvFEfFtPJBejfbUouxcMLVNHg&usqp=CAU")
              ) ,
              accountName: Text("User",
                style: TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
              accountEmail: Text("user@gmail.com",
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
          ],
        )
      ),
      body: ListView.builder(
        padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
        itemCount: controller.musicas.length *2 -1,
        itemBuilder: (context, i){

          if(i.isOdd){
            return DividerGradient();
          }

          final musica = controller.musicas;
          final itemIndex = i ~/2;
          return Container(
            padding: EdgeInsets.only(top: 4, bottom: 4),
            child: ListTile(
              style: ListTileStyle.list,
              leading: CircleAvatar(
                backgroundColor: Colors.grey[300],
                radius: 30,
              ),
              title: Text(musica[itemIndex].nome,
                style: TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
              subtitle: Text(musica[itemIndex].artista,
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
                      child: Icon(
                        Icons.play_circle,
                        color: Colors.white,
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
