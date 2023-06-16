import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{



  /*WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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


