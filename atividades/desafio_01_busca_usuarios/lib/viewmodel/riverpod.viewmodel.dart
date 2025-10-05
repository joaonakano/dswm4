import 'package:desafio_01_busca_usuarios/models/user.model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ===============================================
// PARTE 2: GERENCIAMENTO DE ESTADO COM O RIVERPOD
// ===============================================

// Para o Riverpod, usamos StateNotifier e StateNotifierProvider
// StateNotifier é uma versão mais robusta e testável do ChangeNotifier

class OnlineUsersStateNotifier extends Notifier<List<User>> {

  // O construtor inicializa o estado com a lista de usuários
  @override
  List<User> build() {
    return [
      User(id: '1', name: 'Alice', isOnline: true),
      User(id: '2', name: 'Joao'),
      User(id: '3', name: 'Vinicius ', isOnline: true),
      User(id: '4', name: 'Bob'),
    ];
  }
  
  // Método para alternar o status
  void toggleStatus(String userId) {
    // O estado no StateNotifier é imutável
    // Primeiro, criamos uma nova lista a partir do estado atual
    final newUsers = [...state];

    // Encontramos o índice do usuário a ser modificado
    final userIndex = newUsers.indexWhere((user) => user.id == userId);

    // Invertemos o status online na nova lista
    newUsers[userIndex].isOnline = !newUsers[userIndex].isOnline;

    // Atribuímos a nova lista ao estado. Isso dispara a atualização do estado
    state = newUsers;
  }

  List<User> filterUsers(String query) {
    if (query.isEmpty) {
      return state;
    }

    final lowercaseQuery = query.toLowerCase().trim();

    return state.where((user) {
      return user.name.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }
}
