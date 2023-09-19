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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home(),
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
          ],
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
