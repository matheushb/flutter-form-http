import 'package:mobile/enums/tipo_transacao.dart';
import 'package:uuid/uuid.dart';

class Transacao {
  late final String id;
  final double valor;
  final TipoTransacao tipoTransacao;

  Transacao(this.valor, this.tipoTransacao) {
    id = const Uuid().v4();
  }

  Transacao.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        valor = json['valor'],
        tipoTransacao = TipoTransacao.values
            .firstWhere((e) => e.name == json['tipoTransacao']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'valor': valor,
      'tipoTransacao': tipoTransacao.name,
    };
  }
}
