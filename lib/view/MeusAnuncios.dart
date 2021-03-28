import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:olx/helper/UsuarioFirebase.dart';
import 'package:olx/models/Anuncio.dart';
import 'package:olx/view/widgets/ItemAnuncio.dart';

class MeusAnuncios extends StatefulWidget {
  @override
  _MeusAnunciosState createState() => _MeusAnunciosState();
}

class _MeusAnunciosState extends State<MeusAnuncios> {
  final _controller = StreamController<QuerySnapshot>.broadcast();
  String _idUsuario = "";

  recuperarIdUsuario() async {
    String id = await UsuarioFirebase.getIdUsuario();
    setState(() {
      _idUsuario = id;
    });
  }

  Future<Stream<QuerySnapshot>> _adicionarListenerAnuncios() async {
    await recuperarIdUsuario();

    FirebaseFirestore db = FirebaseFirestore.instance;

    Stream<QuerySnapshot> stream = db
        .collection("meus_anuncios")
        .doc(_idUsuario)
        .collection("anuncios")
        .snapshots();

    stream.listen((dados) {
      _controller.add(dados);
    });
  }

  @override
  void initState() {
    super.initState();
    _adicionarListenerAnuncios();
  }

  _removerAnuncio(String idAnuncio) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    db
        .collection("meus_anuncios")
        .doc(_idUsuario)
        .collection("anuncios")
        .doc(idAnuncio)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    var carregandoDados = Center(
      child: Column(
        children: [Text("Carregando anúncios"), CircularProgressIndicator()],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Anúncios"),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, "/novo-anuncio");
        },
      ),
      body: StreamBuilder(
        stream: _controller.stream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return carregandoDados;
              break;
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError) Text("Erro ao carregar os dados!");
              QuerySnapshot querySnapshot = snapshot.data;
              return ListView.builder(
                itemCount: querySnapshot.docs.length,
                itemBuilder: (_, indice) {
                  List<DocumentSnapshot> anuncios = querySnapshot.docs.toList();
                  DocumentSnapshot documentSnapshot = anuncios[indice];
                  Anuncio anuncio =
                      Anuncio.fromDocumentSnapshot(documentSnapshot);

                  return ItemAnuncio(
                    anuncio: anuncio,
                    onPressedRemover: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Confirmar"),
                              content:
                                  Text("Deseja realmente excluir o anúncio"),
                              actions: [
                                FlatButton(
                                  child: Text(
                                    "Cancelar",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                FlatButton(
                                  child: Text(
                                    "Remover",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  onPressed: () {
                                    _removerAnuncio(anuncio.id);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });
                    },
                  );
                },
              );
          }
          return Container();
        },
      ),
    );
  }
}
