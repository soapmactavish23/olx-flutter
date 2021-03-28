import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:olx/models/Usuario.dart';

class UsuarioFirebase {

  static Future<User> getUsuarioAtual() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    return await auth.currentUser;
  }

  static Future<String> getIdUsuario() async{
    FirebaseAuth auth = FirebaseAuth.instance;
    return await auth.currentUser.uid;
  }

  static Future<Usuario> getDadosUsuarioLogado() async {
    User firebaseUser = await getUsuarioAtual();
    String idUsuario = firebaseUser.uid;

    FirebaseFirestore db = FirebaseFirestore.instance;

    DocumentSnapshot snapshot =
    await db.collection("usuarios").doc(idUsuario).get();

    Map<String, dynamic> dados = snapshot.data();
    String email = dados["email"];
    String nome = dados["nome"];

    Usuario usuario = Usuario();
    usuario.idUsuario = idUsuario;
    usuario.email = email;
    usuario.nome = nome;

    return usuario;
  }

}