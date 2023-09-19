import 'package:app_music/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'cadastro.dart';
import 'login.dart';
import 'package:local_auth/local_auth.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {

  Future<void> _authenticate() async{
    final localAuth = LocalAuthentication();
    try{
      final isAuthenticated = await localAuth.authenticate(
          localizedReason: "Faça login com biometria",
      );

      if (isAuthenticated){
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => Home(),
            ),
        );
      }
    }catch (e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: const EdgeInsets.all(0.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(0.8, 1),
              colors: [
                const Color(0xFF02d9de),
                const Color(0xFF905ef1),
                const Color(0xFFc72ef8),
                const Color(0xFFf902ff),
              ],
              tileMode: TileMode.mirror,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 100),
                child: Image(
                  image: AssetImage('imgs/logo.png'),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: (){

                      //Rota normal
                      /*Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          )
                      );*/

                      //Chamando a rota nomeada do Login()
                      Navigator.of(context).pushNamed('/login');

                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(50, 12, 50, 12),
                      child: Text("Login",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 20
                        ),
                      ),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.white
                        ),
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
                    /*style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),*/
                  )
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Cadastro(),
                          )
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(60, 12, 60, 12),
                      child: Text("Register",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 20
                        ),
                      ),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.white
                        ),
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
                    /*style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        )
                    )*/
                  )
              ),
              Padding(
                padding: EdgeInsets.only(top: 40, bottom: 40),
                child: Text("Or quick login\n with Touch ID",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontSize: 14
                  ),
                ),
              ),
              GestureDetector(
                onTap: _authenticate,
                child: SizedBox(
                  width: 300,
                  height: 100,
                  child: Image.asset("imgs/biometria.png"),
                ),
              )
            ],
          ),
        )
    );
  }
}
