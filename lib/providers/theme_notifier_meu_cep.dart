import 'package:flutter/material.dart';
import 'package:meu_cep/providers/app_theme_meu_cep.dart';

// Importa os pacotes necessários do Flutter e o arquivo theme.dart

class ThemeNotifierMeuCep extends ValueNotifier<MeuCepAppThemeSettings> {
  // Cria uma classe chamada ThemeNotifier que estende ValueNotifier<ThemeSettings>.
  // A classe é responsável por notificar quando as configurações de tema mudam.

  ThemeNotifierMeuCep(MeuCepAppThemeSettings value) : super(value);
  // Construtor da classe. Ele recebe um valor inicial de ThemeSettings (representando as configurações de tema)
  // e passa esse valor para o construtor da classe pai (ValueNotifier) usando a palavra-chave "super".
  // Isso permite que o ValueNotifier gerencie o estado interno e notifique os ouvintes quando o valor muda.

  // A partir deste ponto, você pode adicionar métodos ou funcionalidades específicas
  // para manipular as mudanças nas configurações de tema e notificar os ouvintes.
}
