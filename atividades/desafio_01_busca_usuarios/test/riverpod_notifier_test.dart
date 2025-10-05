import 'package:desafio_01_busca_usuarios/models/user.model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/test.dart';
import '../lib/viewmodel/riverpod.viewmodel.dart';

// =====================================================
// PARTE 4: TESTES UNITÁRIOS DO GERENCIAMENTO DE ESTADOS
// =====================================================

final onlineUsersProvider = NotifierProvider<OnlineUsersStateNotifier, List<User>>(
  OnlineUsersStateNotifier.new
);

void main() {
  group("Testando o Riverpod Provider", () {
    // ProviderContainer simula o ambiente do Riverpod
    late ProviderContainer container;

    setUp(() {
      // Inicializa o container antes dos testes
      container = ProviderContainer();
    });

    tearDown(() {
      // Descarta o container após os testes
      container.dispose();
    });

    test('O estado deve conter 4 usuarios e o status da Alice será TRUE', () {
      // Uso do container.read para obter o estado
      final users = container.read(onlineUsersProvider);

      expect(users.length, 4);

      final alice = users.firstWhere((user) => user.id == '1');
      expect(alice.name, 'Alice');
      expect(alice.isOnline, isTrue);
    });
  });
}