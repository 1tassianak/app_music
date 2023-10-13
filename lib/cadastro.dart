import 'dart:io';
import 'package:app_music/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'home.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {

  String _email = '';
  String _password = '';
  String _nome = '';

  bool obscureText = true;
  IconData icon = Icons.remove_red_eye;

  final imagePicker = ImagePicker();
  File? imageFile;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  pick(ImageSource source) async{
    final pickedFile = await imagePicker.pickImage(source: source);

    if(pickedFile != null){
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  // Função para salvar o usuário no Firestore
  Future<void> saveUsuarioToFirestore(Usuario usuario) async {
    try {
      await FirebaseFirestore.instance.collection('usuarios').doc(usuario.email).set({
        'nome': usuario.nome,
        'email': usuario.email,
        'senha': usuario.senha,
        'imageUrl': usuario.imageUrl,
      });
    } catch (e) {
      print('Erro ao salvar o usuário no Firestore: $e');
      // Trate o erro de acordo com suas necessidades
    }
  }

  Future<void> _register() async{
    String imageUrl = '';
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
      );

      //upload da imagem para o Firebase Storage
      if(imageFile != null){
        Reference storageReference = FirebaseStorage.instance.ref().child('profile_images/${userCredential.user!.uid}');
        UploadTask uploadTask = storageReference.putFile(imageFile!);

        // Aguarde o upload ser concluído
        TaskSnapshot snapshot = await uploadTask;

        // Obtenha a URL da imagem após o upload
        imageUrl = await snapshot.ref.getDownloadURL();

        await uploadTask.whenComplete(() async{
          String imageURL = await storageReference.getDownloadURL();
          //Salva a URL da imagem junto com os outros dados do usuário
          await userCredential.user!.updatePhotoURL(imageURL);
          await userCredential.user!.reload();
        });
      }

      //Cria o objeto Usuario com os dados
      Usuario usuario = Usuario(
        nome: _nome,
        email: _email,
        senha: _password,
        imageUrl: imageUrl
      );
      // Salva o usuário no Firestore
      await saveUsuarioToFirestore(usuario);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        print('Error: $e');
      }
    }
  }

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      const Color(0xFF02d9de),
                                      const Color(0xFF905ef1),
                                      const Color(0xFFf902ff),
                                    ]
                                ),
                                borderRadius: BorderRadius.circular(105)
                            ),
                            child: CircleAvatar(
                                radius: 110,
                                backgroundColor: Colors.grey[300],
                                backgroundImage: imageFile != null ? FileImage(imageFile!) : null,
                              ),
                          ),
                          Positioned(
                            bottom: 15,
                            right: 15,
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              child: IconButton(
                                onPressed: _showOpcoesBottomSheet,
                                icon: Icon(
                                  Icons.add_a_photo_outlined,
                                  color: Colors.grey[400],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
               /* Padding(
                  padding: EdgeInsets.all(0),
                  child: CircleAvatar(
                    radius: 150,
                    backgroundImage: imageFile != null ? FileImage(imageFile!) : null,
                  ),
                ),
                FloatingActionButton(
                  onPressed: (){},
                  child: Icon(Icons.add),
                ),*/
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
                    onPressed: _register,
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

  void _showOpcoesBottomSheet(){
    showModalBottomSheet(
        context: context,
        builder: (_){
          return Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: Center(
                      child: Icon(
                        Icons.image_search,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                  title: Text("Galeria",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  onTap: (){
                    Navigator.of(context).pop();

                    pick(ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: Center(
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                  title: Text("Câmera",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  onTap: (){
                    Navigator.pop(context);
                    pick(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: Center(
                      child: Icon(
                        Icons.restore_from_trash_outlined,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                  title: Text("Remover",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  onTap: (){
                    Navigator.of(context).pop();
                    setState(() {
                      imageFile = null;
                    });
                  },
                )
              ],
            ),
          );
        }
    );
  }

}

