// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meu_cep/models/via_cep_model.dart';

class ViaCepRepository {
  Future<ViaCEPModel> consultarCEP(String cep) async {
    var response =
        await http.get(Uri.parse("https://viacep.com.br/ws/$cep/json/"));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return ViaCEPModel.fromJson(json);
    }
    return ViaCEPModel();
  }
}
