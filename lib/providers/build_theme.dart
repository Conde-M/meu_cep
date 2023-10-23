import 'package:flutter/material.dart';
import 'package:meu_cep/providers/app_theme_meu_cep.dart';
import 'package:meu_cep/providers/theme_notifier_meu_cep.dart';
import 'package:meu_cep/providers/color_schemes_meu_cep.dart';
import 'package:meu_cep/providers/theme_provider_meu_cep.dart';

class BuildTheme extends StatefulWidget {
  final Widget home;
  const BuildTheme({super.key, required this.home});

  @override
  State<BuildTheme> createState() => _BuildThemeState();
}

class _BuildThemeState extends State<BuildTheme> {
  // Define se o modo escuro está ativado ou não
  bool isDarkMode = false;
  // Esquema de cores com base no modo escuro
  late ColorScheme colorScheme;
  // Modo do tema (escuro ou claro)
  late ThemeMode themeMode;
  // Define se o modo inicial foi definido
  bool _initialThemeModeIsSetted = false;
  // Notificador de alterações de tema
  late ThemeNotifierMeuCep themeNotifier;
  @override
  Widget build(BuildContext context) {
    // Obtém o provedor de tema da árvore de widgets
    final themeData = _configureThemeAndNotifier();
    // Constrói a interface do usuário com base nas configurações do tema
    return ValueListenableBuilder<MeuCepAppThemeSettings>(
      valueListenable: themeNotifier,
      builder: (context, settings, _) {
        return ThemeProviderMeuCep(
          themeNotifier: themeNotifier,
          body: MaterialApp(
            themeMode: themeMode,
            key: const Key('meu_cep'),
            title: 'Meu Cep',
            debugShowCheckedModeBanner: false,
            theme: themeData.light(lightColorScheme),
            darkTheme: themeData.dark(darkColorScheme),
            home: widget.home,
          ),
        );
      },
    );
  }

  // Função para alternar entre os modos de tema
  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  // Função para definir o modo inicial com base no brilho do sistema
  void _setInitialThemeMode(BuildContext context) {
    setState(() {
      isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
      _initialThemeModeIsSetted = true;
    });
  }

  // Função para configurar as variáveis de cores e notificador de tema
  AppThemeMeuCep _configureThemeAndNotifier() {
    // Inicializa modo do tema de acordo com a configuração no sistema
    if (_initialThemeModeIsSetted == false) _setInitialThemeMode(context);
    // Define o esquema de cores com base no modo escuro
    colorScheme = isDarkMode ? darkColorScheme : lightColorScheme;
    // Define o modo do tema com base no modo escuro
    themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    // Define o notificador de tema
    themeNotifier = ThemeNotifierMeuCep(
      // Configurações de tema
      MeuCepAppThemeSettings(
        sourceColor: colorScheme.primary,
        themeMode: themeMode,
      ),
    );
    // Retorna o provedor de tema
    return AppThemeMeuCep(
      // Notificador de tema
      settings: themeNotifier,
      // Esquema de cores dinâmico para tema claro
      lightDynamic: lightColorScheme,
      // Esquema de cores dinâmico para tema escuro
      darkDynamic: darkColorScheme,
      child: Container(),
    );
  }
}
