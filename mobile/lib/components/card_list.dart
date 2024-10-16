import 'package:flutter/material.dart';

class CardList extends StatelessWidget {
  final String titulo;
  final String subtitle;

  const CardList(this.titulo, this.subtitle, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      title: Text(titulo),
      subtitle: Text(subtitle),
    ));
  }
}
