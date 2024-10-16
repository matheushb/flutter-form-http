import 'package:flutter/material.dart';
import 'package:mobile/screens/lista_transacoes.dart';

void main() {
  runApp(const MyBank());
}

class MyBank extends StatelessWidget {
  const MyBank({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
        buttonTheme: const ButtonThemeData(
            buttonColor: Colors.deepPurpleAccent,
            textTheme: ButtonTextTheme.primary),
      ),
      home: ListaTransacoes(),
    );
  }
}
