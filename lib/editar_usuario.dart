import 'dart:io';
import 'package:app_music/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'home.dart';

class EditarUsuario extends StatefulWidget {
  final Usuario? usuario;

  const EditarUsuario({this.usuario, Key? key}) : super(key: key);

  @override
  State<EditarUsuario> createState() => _EditarUsuarioState();
}

class _EditarUsuarioState extends State<EditarUsuario> {
  bool _passwordsMatch = true;

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();

  bool obscureText = true;
  IconData icon = Icons.remove_red_eye;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final imagePicker = ImagePicker();
  File? imageFile;

  pick(ImageSource source) async{
    final pickedFile = await imagePicker.pickImage(source: source);

    if(pickedFile != null){
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _nomeController.text = widget.usuario?.nome ?? '';
    _emailController.text = widget.usuario?.email ?? '';
  }

  Future<void> _editUser() async {
    String nome = _nomeController.text;
    String email = _emailController.text;
    String? senha = widget.usuario?.senha;

    // Restante do código para editar o usuário
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Atualiza o nome do usuário
        await user.updateDisplayName(nome);

        // Atualiza a imagem de perfil, se houver uma nova imagem selecionada
        if (imageFile != null) {
          Reference storageReference =
          FirebaseStorage.instance.ref().child('profile_images/${user.uid}');
          UploadTask uploadTask = storageReference.putFile(imageFile!);

          TaskSnapshot snapshot = await uploadTask;
          String imageURL = await snapshot.ref.getDownloadURL();

          // Atualiza a URL da imagem de perfil
          await user.updatePhotoURL(imageURL);
        }

        // Atualiza outras informações do usuário conforme necessário
        // ...

        // Atualiza as informações no Firestore
        Usuario usuarioAtualizado = Usuario(
          nome: nome,
          email: email,
          senha: widget.usuario?.senha ?? '',// Use ?. to access potentially null properties
          imageUrl: user.photoURL ?? '', // Mantenha a imagem original
        );

        await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(user.email)
            .update({
          'nome': usuarioAtualizado.nome,
          'email': usuarioAtualizado.email,
          'senha': usuarioAtualizado.senha,
          'imageUrl': usuarioAtualizado.imageUrl,
        });

        // Atualize os detalhes do usuário após a edição
        updateUserDetails();

        // Navegue de volta para a tela Home
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }
    } catch (e) {
      print('Erro ao editar o usuário: $e');
    }
  }

  Future<void> updateUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      setState(() {
        // Atualiza o nome do usuário
        _nomeController.text = user.displayName ?? '';

        // Atualiza a imagem do perfil
        if (user.photoURL != null && user.photoURL != '') {
          imageFile = File(user.photoURL!);
        }
      });
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
                      controller: _nomeController,
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
                      controller: _emailController,
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
                      onChanged: (value) {
                        setState(() {
                          _passwordController.text = value;
                        });
                      },
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
                        fillColor: Color(0xffe5e5e5),
                        errorText: _passwordsMatch ? null : 'As senhas não conferem',
                      ),
                      onChanged: (value) {
                        // Atualize o estado _passwordsMatch com base na comparação das senhas
                        setState(() {
                          _passwordsMatch = value == _passwordController.text;
                        });
                      },
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
                    onPressed: _editUser,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(55, 8, 55, 8),
                      child: Text("Salvar",
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
    // Após remover a imagem, chame updateUserDetails para atualizar os detalhes do usuário na tela Home
    updateUserDetails();
  }

}
