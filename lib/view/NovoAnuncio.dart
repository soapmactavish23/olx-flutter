import 'package:flutter/material.dart';
import 'package:olx/view/widgets/BotaoCustomizado.dart';

class NovoAnuncio extends StatefulWidget {
  @override
  _NovoAnuncioState createState() => _NovoAnuncioState();
}

class _NovoAnuncioState extends State<NovoAnuncio> {
  final _formKey = GlobalKey<FormState>();

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
                //FormField(),
                //MenusDropDown
                Row(
                  children: <Widget>[Text("Estado"), Text("Categoria")],
                ),
                //Caixas de textos e botoes
                Text("Caixas de textos"),
                BotaoCustomizado(
                  texto: "Cadastrar anúncio",
                  onPressed: (){
                    if(_formKey.currentState.validate());
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
