import 'package:flutter/material.dart';
import 'package:mobile/models/transacao.dart';
import 'package:mobile/screens/form_transacoes.dart';
import 'package:mobile/service/transactions_service.dart';

class ListaTransacoes extends StatefulWidget {
  ListaTransacoes({super.key});

  @override
  State<StatefulWidget> createState() => _ListaTransacoesState();
}

class _ListaTransacoesState extends State<ListaTransacoes> {
  final TransactionsService _service = TransactionsService();
  List<Transacao> _transacoes = [];

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
  }

  void _fetchTransactions() async {
    List<dynamic> transactionsData = await _service.find();
    setState(() {
      _transacoes =
          transactionsData.map((data) => Transacao.fromJson(data)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Transações"),
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView.builder(
        itemCount: _transacoes.length,
        itemBuilder: (context, index) {
          final transacao = _transacoes[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(
                'Valor: R\$ ${transacao.valor.toStringAsFixed(2)}',
              ),
              subtitle: Text('Tipo: ${transacao.tipoTransacao.name}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _editTransaction(context, transacao),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteTransaction(transacao.id),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FormTransacoes(
              valueController: TextEditingController(),
            ),
          ),
        ).then((value) => _createTransaction(value)),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _createTransaction(Transacao? transacao) async {
    if (transacao == null) return;
    await _service.create(transacao.toJson());
    _fetchTransactions();
  }

  void _editTransaction(BuildContext context, Transacao transacao) {
    final valueController =
        TextEditingController(text: transacao.valor.toString());

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormTransacoes(
          valueController: valueController,
          initialTipo: transacao.tipoTransacao,
        ),
      ),
    ).then((updatedTransacao) async {
      if (updatedTransacao != null) {
        await _service.update(transacao.id, updatedTransacao.toJson());
        _fetchTransactions();
      }
    });
  }

  void _deleteTransaction(String id) async {
    await _service.delete(id);
    _fetchTransactions();
  }
}
