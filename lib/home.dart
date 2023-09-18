import 'package:flutter/material.dart';

import 'favoritos.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
          children: ListTile.divideTiles(
              context: context,
                tiles: [
                  ListTile(
                    leading: Icon(Icons.favorite),
                    title: Text("Músicas Curtidas"),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Favoritos(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.music_note),
                    title: Text("Playlist"),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        ),
                      );
                    },
                  ),
                ]
            ).toList(),
        )
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
        children: [
          SizedBox(
            height: 60,
            child: ListTile(
              style: ListTileStyle.list,
              leading: CircleAvatar(
                backgroundColor: Colors.grey[300],
                radius: 30,
              ),
              title: Text("Song Title",
                style: TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
              subtitle: Text("Artist",
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
          ),
          Container(
            margin: EdgeInsets.only(top: 16, bottom: 8),
            width: 100,
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
          SizedBox(
            height: 60,
            child: ListTile(
              style: ListTileStyle.list,
              leading: CircleAvatar(
                backgroundColor: Colors.grey[300],
                radius: 30,
              ),
              title: Text("Song Title",
                style: TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
              subtitle: Text("Artist",
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
          ),
          Container(
            margin: EdgeInsets.only(top: 16, bottom: 8),
            width: 100,
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
        ],
      ),
    );
  }
}
