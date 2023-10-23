class Back4AppAddressModel {
  String localidade = "";
  String uf = "";
  String cep = "";

  Back4AppAddressModel(this.localidade, this.uf, this.cep);

  Back4AppAddressModel.fromJson(Map<String, dynamic> json) {
    localidade = json['localidade'];
    uf = json['uf'];
    cep = json['cep'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['localidade'] = localidade;
    data['uf'] = uf;
    data['cep'] = cep;
    return data;
  }

  Map<String, dynamic> toJsonEndpoint() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['localidade'] = localidade;
    data['uf'] = uf;
    data['cep'] = cep;
    return data;
  }
}
