import 'package:app_music/login.dart';
import 'package:flutter/material.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {

  bool obscureText = true;
  IconData icon = Icons.remove_red_eye;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(0),
                  child: CircleAvatar(
                    radius: 150,
                    backgroundImage: AssetImage("imgs/avatar.jpg"),
                  ),
                ),
                FloatingActionButton(
                  onPressed: (){},
                  child: Icon(Icons.add),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: 300,
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                          label: Text("Name",
                            style: TextStyle(
                                color: Color(0xffafafaf)
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          fillColor: Color(0xffe5e5e5)
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: SizedBox(
                    width: 300,
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                          label: Text("E-mail",
                            style: TextStyle(
                                color: Color(0xffafafaf)
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          fillColor: Color(0xffe5e5e5)
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: 300,
                    height: 50,
                    child: TextField(
                      obscureText: obscureText,
                      decoration: InputDecoration(
                          label: Text("Password",
                            style: TextStyle(
                                color: Color(0xffafafaf)
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(icon),
                            onPressed: (){
                              if(obscureText == true){
                                setState(() {
                                  obscureText = false;
                                });
                              }else{
                                setState(() {
                                  obscureText = true;
                                });
                              }
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          fillColor: Color(0xffe5e5e5)
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: SizedBox(
                    width: 300,
                    height: 50,
                    child: TextField(
                      obscureText: obscureText,
                      decoration: InputDecoration(
                          label: Text("Repeat Password",
                            style: TextStyle(
                                color: Color(0xffafafaf)
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(icon),
                            onPressed: (){
                              if(obscureText == true){
                                setState(() {
                                  obscureText = false;
                                });
                              }else{
                                setState(() {
                                  obscureText = true;
                                });
                              }
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          fillColor: Color(0xffe5e5e5)
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            const Color(0xFF02d9de),
                            const Color(0xFF905ef1),
                            const Color(0xFFf902ff),
                          ]
                      ),
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          )
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(55, 8, 55, 8),
                      child: Text("Cadastrar",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 20
                        ),
                      ),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.transparent
                        ),
                        shadowColor: MaterialStateProperty.all(Colors.transparent),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            )
                        ),
                        overlayColor: MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states){
                              if (states.contains(MaterialState.pressed))
                                return Colors.purpleAccent;
                              return null;
                            }
                        )
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
