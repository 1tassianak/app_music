import 'package:flutter/material.dart';

import 'cadastro.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool obscureText = true;
  IconData icon = Icons.remove_red_eye;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Container(
              padding: const EdgeInsets.fromLTRB(8, 80, 8, 80),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                    child: Image(
                      image: AssetImage('imgs/logo1.png'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 60),
                    child: Text("SIGN IN\nTO CONTINUE",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          letterSpacing: 2
                      ),
                    )
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
                        child: Text("Login",
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
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: GestureDetector(
                      onTap: (){},
                      child: Text("Lost Password?",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                        padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
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
                        child: ElevatedButton.icon(
                          /*icon: Icon(Icons.home,
                              color: Colors.green,
                              size: 25
                          ),*/
                          icon: Image.asset('imgs/google.png'),
                          label: Text(" Google ",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontSize: 14,
                            ),
                          ),
                          onPressed: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                )
                            );
                          },
                          /*child: Padding(
                            padding: const EdgeInsets.fromLTRB(35, 9, 35, 9),
                            child: Text("Google",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  fontSize: 12
                              ),
                            ),
                          ),*/
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                              EdgeInsets.fromLTRB(10, 0, 30, 0)
                            ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white
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
                      SizedBox(
                        width: 30,
                      ),
                      Container(
                        height: 40,
                        padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
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
                        child: ElevatedButton.icon(
                          icon: Image.asset('imgs/face.png'),
                          label: Text("Facebook",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontSize: 14
                            ),
                          ),
                          onPressed: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                )
                            );
                          },
                          /*child: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 9, 30, 9),
                            child: Text("Facebook",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  fontSize: 12
                              ),
                            ),
                          ),*/
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white
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
                  SizedBox(
                    height: 100,
                  ),
                  Expanded(
                    child: Container(
                      width: 80,
                      child: Divider(
                        color: Colors.black54,
                        thickness: 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(0),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Cadastro(),
                            ),
                        );
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                            ),
                          ),
                          Text(" Register",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold
                              )
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
