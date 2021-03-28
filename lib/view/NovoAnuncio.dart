import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:olx/view/widgets/BotaoCustomizado.dart';
import 'dart:io';

class NovoAnuncio extends StatefulWidget {
  @override
  _NovoAnuncioState createState() => _NovoAnuncioState();
}

class _NovoAnuncioState extends State<NovoAnuncio> {
  List<File> _listaImagens = List();
  final _formKey = GlobalKey<FormState>();

  _selecionarImagemGaleria() async {
    File imagemSelecionada;

    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);

    imagemSelecionada = File(pickedFile.path);


    if(imagemSelecionada != null){
      setState(() {
        _listaImagens.add(imagemSelecionada);
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Novo Anúncio"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                //área de imagens
                FormField<List>(
                  initialValue: _listaImagens,
                  validator: (imagens) {
                    if (imagens.length == 0) {
                      return "Necessário selecionar uma imagem!";
                    }
                    return null;
                  },
                  builder: (state) {
                    return Column(
                      children: [
                        Container(
                          height: 100,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _listaImagens.length + 1,
                              itemBuilder: (context, indice) {
                                if (indice == _listaImagens.length) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: GestureDetector(
                                      onTap: () {
                                        _selecionarImagemGaleria();
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.grey,
                                        radius: 50,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.add_a_photo,
                                              size: 40,
                                              color: Colors.grey[100],
                                            ),
                                            Text(
                                              "Adicionar",
                                              style: TextStyle(
                                                  color: Colors.grey[100]),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }

                                if (_listaImagens.length > 0) {
                                  return Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8),
                                      child: GestureDetector(
                                        onTap: (){
                                          showDialog(
                                              context: context,
                                              builder: (context) => Dialog(
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                  Image.file(_listaImagens[indice]),
                                                  FlatButton(
                                                    child: Text("Excluir"),
                                                    textColor: Colors.red,
                                                    onPressed: (){
                                                      setState(() {
                                                        _listaImagens.removeAt(indice);
                                                        Navigator.of(context).pop();
                                                      });
                                                    },
                                                  )
                                                ],),
                                              )
                                          );
                                        },
                                        child: CircleAvatar(
                                          radius: 50,
                                          backgroundImage: FileImage(_listaImagens[indice]),
                                          child: Container(
                                            color: Color.fromRGBO(255, 255, 255, 0.4),
                                            alignment: Alignment.center,
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ),
                                  );
                                }

                                return Container();
                              }),
                        ),
                        if (state.hasError)
                          Container(
                              child: Text("${state.errorText}",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 14)))
                      ],
                    );
                  },
                ),
                //MenusDropDown
                Row(
                  children: [Text("Estado"), Text("Categoria")],
                ),
                //Caixas de textos e botoes
                Text("Caixas de textos"),
                BotaoCustomizado(
                  texto: "Cadastrar anúncio",
                  onPressed: () {
                    if (_formKey.currentState.validate()) ;
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
