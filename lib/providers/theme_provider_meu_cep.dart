import 'package:flutter/material.dart';
import 'package:meu_cep/providers/app_theme_meu_cep.dart';
import 'package:meu_cep/providers/theme_notifier_meu_cep.dart';
import 'package:meu_cep/providers/color_schemes_meu_cep.dart';

// Widget ProvideTheme: um StatefulWidget que envolve o aplicativo com o tema fornecido
class ThemeProviderMeuCep extends StatefulWidget {
  // Notificador de alterações de tema
  final ThemeNotifierMeuCep themeNotifier;
  // Widget do corpo do aplicativo
  final Widget body;
  const ThemeProviderMeuCep({
    required this.themeNotifier,
    required this.body,
    super.key,
  });

  @override
  State<ThemeProviderMeuCep> createState() => _ThemeProviderMeuCepState();
}

class _ThemeProviderMeuCepState extends State<ThemeProviderMeuCep> {
  @override
  AppThemeMeuCep build(BuildContext context) {
    return AppThemeMeuCep(
      // Configurações de tema do notificador
      settings: widget.themeNotifier,
      // Esquema de cores dinâmico para tema claro
      lightDynamic: lightColorScheme,
      // Esquema de cores dinâmico para tema escuro
      darkDynamic: darkColorScheme,
      // Corpo do aplicativo
      child: widget.body,
    );
  }
}
