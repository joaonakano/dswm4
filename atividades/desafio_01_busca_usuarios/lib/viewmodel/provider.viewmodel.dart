import 'package:desafio_01_busca_usuarios/models/user.model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ===============================================
// PARTE 1: GERENCIAMENTO DE ESTADO COM O PROVIDER
// ===============================================

// O provider que irá fornecer a nossa ViewModel (OnlineUsersNotifier) para a árvore de widgets
// Ele é colocado no topo da árvore. Senão, os componentes não são atualizados adequadamente
// COMANDOS DEPRECIADOS: final onlineUsersProvider = ChangeNotifierProvider((ref) => OnlineUsersNotifier());
final onlineUsersProvider = ChangeNotifierProvider(
  create: (ref) => OnlineUsersNotifier(),
);

// Criando a classe ViewModel para o Provider
// Ela estende ChangeNotifier, um "emissor" de notificação de mudanças
class OnlineUsersNotifier extends ChangeNotifier {
  // Lista privada de usuários. '_' indica que ela é privada
  final List<User> _users = [
    User(id: '1', name: 'Alice', isOnline: true),
    User(id: '2', name: 'Joao'),
    User(id: '3', name: 'Vinicius ', isOnline: true),
    User(id: '4', name: 'Bob'),
  ];

  // Getter para expor a lista de forma segura (sem permitir mudanças diretas)
  // 'get' é uma palavra reservada do Dart para criar um Getter
  List<User> get users => _users;

  // Método para alterar o status online de um usuário
  void toggleStatus(String userId) {
    // Procura o usuário na lista pelo ID
    // Usando ainda a propriedade privada com uma função de busca
    final user = _users.firstWhere((user) => user.id == userId);

    // Inverte o status online
    user.isOnline = !user.isOnline;

    // Notifica todos os "ouvintes" que o estado mudou
    notifyListeners();
  }
}