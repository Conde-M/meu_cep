import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meu_cep/models/back4app_address_model.dart';
import 'package:meu_cep/pages/search_cep.dart';
import 'package:meu_cep/providers/build_theme.dart';
import 'package:meu_cep/repositories/back4app_address_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(
    const BuildTheme(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Back4AppAddressRepository _back4AppAddressRepository =
      Back4AppAddressRepository();
  bool loading = false;
  late Back4AppAddressModel ceps;

  @override
  void initState() {
    super.initState();
    _loadCeps();
  }

  _loadCeps() async {
    setState(() {
      loading = true;
    });
    ceps = await _back4AppAddressRepository.obterEndereco(null);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Constrói a interface do usuário com base nas configurações do tema
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Meu Cep')],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SearchCep()));
        },
        child: const Icon(Icons.search),
      ),
      body: _listaCep(ceps),
    );
  }
}

Widget _listaCep(ceps) {
  return Container(
    padding: const EdgeInsets.all(8),
    child: ListView.separated(
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemCount: ceps.length,
      itemBuilder: (BuildContext context, int index) {
        return ListBody(
          children: [
            Dismissible(
              direction: DismissDirection.startToEnd,
              background: Container(
                  color: Theme.of(context).colorScheme.inverseSurface,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 24),
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: Theme.of(context).colorScheme.onInverseSurface,
                      ),
                      Text(
                        " Remover",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onInverseSurface,
                            ),
                      ),
                    ],
                  )),
              // Informações da entrada de IMC
              key: Key(index.toString()),
              child: ListTile(
                title: Text(ceps[index]),
                subtitle: const Text('Rua, Bairro, Cidade - UF'),
                onTap: () {},
              ),
            ),
            // Espaço adicional após a última entrada
            if (index == ceps.length - 1) const SizedBox(height: 70),
          ],
        );
      },
    ),
  );
}
