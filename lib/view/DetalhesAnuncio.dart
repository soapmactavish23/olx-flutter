import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:olx/models/Anuncio.dart';

import '../main.dart';

class DetalhesAnuncio extends StatefulWidget {

  Anuncio anuncio;

  DetalhesAnuncio(this.anuncio);

  @override
  _DetalhesAnuncioState createState() => _DetalhesAnuncioState();
}

class _DetalhesAnuncioState extends State<DetalhesAnuncio> {

  Anuncio _anuncio;

  List<Widget> _getListaImagens(){
    List<String> listaUrlImagens = _anuncio.fotos;
    return listaUrlImagens.map((url){
      return Container(
        height: 300,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(url),
            fit: BoxFit.fitWidth
          )
        ),
      );
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _anuncio = widget.anuncio;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Anúncio"),
      ),
      body: Stack(children: [
        ListView(children: [
          SizedBox(
            height: 250,
            child: Carousel(
              images: _getListaImagens(),
              dotSize: 8,
              dotBgColor: Colors.transparent,
              dotColor: Colors.white,
              autoplay: false,
              dotIncreasedColor: temaPadrao.primaryColor,
            ),
          )
        ],)
      ],),
    );
  }
}
