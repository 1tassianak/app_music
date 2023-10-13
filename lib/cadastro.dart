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

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();

  //dispose() está sendo usada para liberar os recursos associados aos TextEditingControllers (gestão de memória)
  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

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

  // Função para exibir uma mensagem se o e-mail já estiver em uso
  void _showEmailAlreadyInUseMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('O e-mail já está sendo usado por outra conta.'),
        duration: Duration(seconds: 3), // Duração da mensagem
      ),
    );
  }

  Future<void> _register() async{
    String nome = _nomeController.text;
    String email = _emailController.text;
    String senha = _passwordController.text;
    String senha2 = _password2Controller.text;

    String imageUrl = '';
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: senha,
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

          // Definir o nome do usuário (display name)
          await userCredential.user!.updateDisplayName(nome);

          // Recarregar o usuário para aplicar as alterações
          await userCredential.user!.reload();
        });
      }

      //Cria o objeto Usuario com os dados
      Usuario usuario = Usuario(
        nome: nome,
        email: email,
        senha: senha,
        imageUrl: imageUrl
      );
      // Salva o usuário no Firestore
      await saveUsuarioToFirestore(usuario);

      // Após salvar o usuário, chame updateUserDetails para atualizar os detalhes do usuário na tela Home
      updateUserDetails();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        _showEmailAlreadyInUseMessage(); // Chama a função para exibir a mensagem
      } else {
        print('Error: $e');
      }
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

  void _showPasswordMismatchMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('As senhas não conferem.'),
        duration: Duration(seconds: 3), // Duração da mensagem
      ),
    );
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
                          fillColor: Color(0xffe5e5e5)
                      ),
                      onChanged: (value) {
                        // Aqui você verifica se as senhas são iguais
                        if (_password2Controller.text != value) {
                          // Senhas não conferem, você pode mostrar uma mensagem
                          // ou fazer algo apropriado ao seu aplicativo
                          print("As senhas não conferem");
                          _showPasswordMismatchMessage();
                        }
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
    // Após remover a imagem, chame updateUserDetails para atualizar os detalhes do usuário na tela Home
    updateUserDetails();
  }

}

