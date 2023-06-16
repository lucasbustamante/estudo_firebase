import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  /*
  FirebaseFirestore db = FirebaseFirestore.instance;
  db.collection("usuarios")
  .doc("002")
  .set({"nome":"Lucas",
  "idade":"29"});

  db.collection("noticias")
  .add({
    "titulo": "Criada nova moeda virtual",
    "descricao":"texto de exemplo"
  });

  FirebaseAuth auth = FirebaseAuth.instance;

  String email = "lucascostabustamante@gmail.com";
  String senha = "123456";

  auth.createUserWithEmailAndPassword(
      email: email,
      password: senha)
      .then((firebaseUser){ print("novo usuario" ); })
      .catchError((erro){ print("erro"); });*/

  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? _imagem;
  String? _imageUrl;

  Future<void> _recuperarImagem(bool daCamera) async {
    late File imagemSelecionada;

    if (daCamera) {
      final imagem = await ImagePicker().pickImage(source: ImageSource.camera);
      imagemSelecionada = imagem != null ? File(imagem.path) : File('');
    } else {
      final imagem = await ImagePicker().pickImage(source: ImageSource.gallery);
      imagemSelecionada = imagem != null ? File(imagem.path) : File('');
    }
    setState(() {
      _imagem = imagemSelecionada;
    });
  }

  Future<void> _uploadImagem() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference pastaRaiz = storage.ref();
    Reference arquivo = pastaRaiz.child("fotos").child("foto1.jpg");

    UploadTask uploadTask = arquivo.putFile(_imagem!);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    String url = await taskSnapshot.ref.getDownloadURL();

    setState(() {
      _imageUrl = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Upload de Foto'),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                _recuperarImagem(true);
              },
              child: Text('Câmera'),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                _recuperarImagem(false);
              },
              child: Text('Galeria'),
            ),
            _imagem == null ? Container() : Image.file(_imagem!),
            ElevatedButton(
              onPressed: () {
                _uploadImagem();
              },
              child: Text('Upload'),
            ),
            _imageUrl != null ? Text(_imageUrl!) : Container(),
          ],
        ),
      ),
    );
  }
}


