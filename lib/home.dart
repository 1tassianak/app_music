import 'package:flutter/material.dart';

import 'favoritos.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
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
                            builder: (context) => Home(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.music_note),
                    title: Text("Playlist"),
                    onTap: (){},
                  ),
                ]
            ).toList(),
        )
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Teste"),
          )
        ],
      ),
    );
  }
}
