import 'package:flutter/material.dart';
import 'package:meu_cep/models/via_cep_model.dart';
import 'package:meu_cep/repositories/via_cep_repository.dart';

class SearchCep extends StatefulWidget {
  const SearchCep({super.key});

  @override
  State<SearchCep> createState() => _SearchCepState();
}

class _SearchCepState extends State<SearchCep> {
  var cepController = TextEditingController(text: "");
  bool loading = false;
  var viacepModel = ViaCEPModel();
  var viaCEPRepository = ViaCepRepository();
  // GlobalKey para o formulário
  final formKey = GlobalKey<FormState>();
  final FocusNode cepFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Theme.of(context).dialogTheme.backgroundColor,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Buscar CEP"),
            centerTitle: true,
            backgroundColor: Theme.of(context).dialogTheme.backgroundColor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: Title(
                    color: Theme.of(context).colorScheme.primary,
                    child: Text(
                      "Buscar CEP",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
                    child: TextFormField(
                      controller: cepController,
                      keyboardType: TextInputType.number,
                      focusNode: cepFocus,
                      onChanged: (String value) async {
                        var cep = value.replaceAll(RegExp(r'[^0-9]'), '');
                        if (cep.length == 8) {
                          setState(() {
                            loading = true;
                            cepFocus.unfocus();
                          });
                          viacepModel =
                              await viaCEPRepository.consultarCEP(cep);
                        }
                        if (cep.length < 8) {
                          setState(() {
                            viacepModel = ViaCEPModel();
                          });
                        }
                        setState(() {
                          loading = false;
                        });
                      },
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface),
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding:
                              const EdgeInsetsDirectional.only(start: 12.0),
                          child: Icon(
                            Icons.home,
                            color: Theme.of(context)
                                .inputDecorationTheme
                                .iconColor,
                          ),
                        ),
                        labelText: "CEP",
                        hintText: "Digite o CEP",
                      ),
                      onTapOutside: (event) {
                        // Remove o foco do campo quando tocado fora
                        cepFocus.unfocus();
                      },
                    ),
                  ),
                ),
                if (loading) const CircularProgressIndicator(),
                Flexible(
                  flex: 2,
                  child: Column(
                    children: [
                      if (cepController.text.length == 8 &&
                          viacepModel.logradouro == null)
                        Text(
                          "CEP não encontrado",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color: Theme.of(context).colorScheme.error),
                        ),
                      Text(
                        viacepModel.logradouro ?? "",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            viacepModel.localidade ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                          ),
                          Text(
                              viacepModel.uf != null &&
                                      viacepModel.localidade != null
                                  ? " / "
                                  : "",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary)),
                          Text(
                            viacepModel.uf ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                cepController.text.length < 8
                    ? const Spacer()
                    : Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                cepController.clear();
                                setState(() {
                                  viacepModel = ViaCEPModel();
                                });
                                cepFocus.requestFocus();
                              },
                              child: const Text("Limpar"),
                            ),
                            FilledButton(
                                onPressed: () {}, child: const Text("Salvar"))
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
