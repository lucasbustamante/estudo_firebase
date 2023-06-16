import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  File? _imagem;

  Future<void> _recuperarImagem(bool daCamera) async{

    late File imagemSelecionada;

    if (daCamera) {
      final imagem = await ImagePicker().getImage(source: ImageSource.camera);
      imagemSelecionada = imagem != null ? File(imagem.path) : File('');
    } else {
      final imagem = await ImagePicker().getImage(source: ImageSource.gallery);
      imagemSelecionada = imagem != null ? File(imagem.path) : File('');
    }
    setState(() {
      _imagem = imagemSelecionada;
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
                onPressed: (){
                  _recuperarImagem(true);
                },
                child: Text('Camera')),
            SizedBox(height: 30),
            ElevatedButton(
                onPressed: (){
                  _recuperarImagem(false);
                },
                child: Text('Galeria')),
            _imagem == null 
                ? Container() 
                : Image.file(_imagem!)
          ],
        ),
      ),
    );
  }
}