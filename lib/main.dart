import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:viva_store/firebase_options.dart';
import 'pages/intro_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Adicionar no Cloud Firestore
  // FirebaseFirestore.instance.collection("produto").doc().set({
  //   "id_produto": const Uuid().v4(),
  //   "nome_prod": "Tenis-New-Balance-WRL24TI",
  //   "desc_prod": "Tenis-New-Balance-NOVO",
  //   "categoria_prod": "vestuário",
  //   "imagem_prod":
  //       "https://centralsurf.vteximg.com.br/arquivos/ids/223465-1000-1000/Tenis-New-Balance-WRL24TI.jpg?v=636717579174930000",
  //   "estoque": "20",
  //   "valor": "450.50"
  // });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroPage(),
    );
  }
}
