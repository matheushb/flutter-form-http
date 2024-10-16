import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class Service<E> {
  final String baseUrl = "http://localhost:3000";

  Future<List<E>> find() async {
    final response = await http.get(Uri.parse('$baseUrl/${entity()}'));
    return json.decode(response.body);
  }

  Future<E> findOne(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/${entity()}/$id'));
    return json.decode(response.body);
  }

  Future<E> create(Object body) async {
    final response = await http.post(Uri.parse('$baseUrl/${entity()}'),
        body: jsonEncode(body));
    return json.decode(response.body);
  }

  Future<E> delete(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/${entity()}/$id'));
    return json.decode(response.body);
  }

  Future<E> update(String id, Object body) async {
    final response = await http.patch(Uri.parse('$baseUrl/${entity()}/$id'),
        body: jsonEncode(body));
    return json.decode(response.body);
  }

  String entity();
}
