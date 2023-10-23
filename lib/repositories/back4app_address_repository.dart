import 'package:meu_cep/models/back4app_address_model.dart';
import 'package:meu_cep/repositories/back4app_custom_dio.dart';

class Back4AppAddressRepository {
  final _customDio = Back4AppCustonDio();

  Back4AppAddressRepository();

  Future<Back4AppAddressModel> obterEndereco(String? cep) async {
    var url = "/Adresses";
    if (cep != null) {
      url = "$url?where={\"cep\":\"$cep\"}";
    }
    var result = await _customDio.dio.get(url);
    if (result.data["results"].isEmpty) {
      return Back4AppAddressModel("", "", "");
    }
    return Back4AppAddressModel.fromJson(result.data);
  }

  Future<void> criar(Back4AppAddressModel back4AppAddressModel) async {
    try {
      await _customDio.dio
          .post("/Adresses", data: back4AppAddressModel.toJsonEndpoint());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> atualizar(Back4AppAddressModel back4AppAddressModel) async {
    try {
      await _customDio.dio.put("/Adresses/${back4AppAddressModel.cep}",
          data: back4AppAddressModel.toJsonEndpoint());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> remover(String objectId) async {
    try {
      await _customDio.dio.delete(
        "/Endereco/$objectId",
      );
    } catch (e) {
      rethrow;
    }
  }
}
