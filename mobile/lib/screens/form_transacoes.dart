import 'package:flutter/material.dart';
import 'package:mobile/enums/tipo_transacao.dart';
import 'package:mobile/models/transacao.dart';

class FormTransacoes extends StatefulWidget {
  final TextEditingController valueController;
  final TipoTransacao initialTipo;

  FormTransacoes({
    super.key,
    required this.valueController,
    this.initialTipo = TipoTransacao.credito,
  });

  @override
  State<FormTransacoes> createState() => _FormTransacoesState();
}

class _FormTransacoesState extends State<FormTransacoes> {
  TipoTransacao? _selectedTipo;

  @override
  void initState() {
    super.initState();
    _selectedTipo = widget.initialTipo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Formulário de Transações"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: widget.valueController,
              ),
            ),
            DropdownButton<TipoTransacao>(
              value: _selectedTipo,
              items: TipoTransacao.values.map((TipoTransacao tipo) {
                return DropdownMenuItem<TipoTransacao>(
                  value: tipo,
                  child: Text(tipo.name),
                );
              }).toList(),
              onChanged: (TipoTransacao? newValue) {
                setState(() {
                  _selectedTipo = newValue!;
                });
              },
            ),
            ElevatedButton(
              onPressed: () => _createTransaction(context),
              child: const Text('Confirmar'),
            )
          ],
        ),
      ),
    );
  }

  void _createTransaction(BuildContext context) {
    double? parsedValue = double.tryParse(widget.valueController.text);

    if (parsedValue == null || _selectedTipo == null) {
      return;
    }

    final newTransaction = Transacao(parsedValue, _selectedTipo!);
    Navigator.pop(context, newTransaction);
  }
}
