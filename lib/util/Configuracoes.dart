import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';

class Configuracoes{
  static List<DropdownMenuItem<String>> getCategorias(){
    List<DropdownMenuItem<String>> itensDropCategorias = [];

    //Categorias
    itensDropCategorias.add(DropdownMenuItem(
      child: Text("Categoria"
      , style: TextStyle(
          color: Color(0xff9c27b0)
        ),),
      value: null,
    ));

    itensDropCategorias.add(DropdownMenuItem(
      child: Text("Automóvel"),
      value: "auto",
    ));

    itensDropCategorias.add(DropdownMenuItem(
      child: Text("Imóvel"),
      value: "imovel",
    ));

    itensDropCategorias.add(DropdownMenuItem(
      child: Text("Eletrônico"),
      value: "eletro",
    ));

    itensDropCategorias.add(DropdownMenuItem(
      child: Text("Moda"),
      value: "moda",
    ));

    return itensDropCategorias;

  }

  static List<DropdownMenuItem<String>> getEstados(){
    List<DropdownMenuItem<String>> listaItensDropEstados = [];

    //Estados
    listaItensDropEstados.add(DropdownMenuItem(
      child: Text("Região"
        , style: TextStyle(
            color: Color(0xff9c27b0)
        ),),
      value: null,
    ));

    //Estados
    for (var estado in Estados.listaEstadosSigla) {
      listaItensDropEstados.add(DropdownMenuItem(
        child: Text(estado),
        value: estado,
      ));
    }

    return listaItensDropEstados;

  }

}