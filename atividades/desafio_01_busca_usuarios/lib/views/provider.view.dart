import 'package:desafio_01_busca_usuarios/viewmodel/provider.viewmodel.dart';
import 'package:desafio_01_busca_usuarios/views/usertile.utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ===============================================
// WIDGETS DE VISUALIZAÇÃO (PROVIDER)
// ===============================================

// Widget que consome o estado usando o pacote 'provider'
class ProviderView extends StatelessWidget {
  const ProviderView({super.key});

  @override
  Widget build(BuildContext context) {
    // Usamos o 'Consumer' para escutar o Provider
    // Apenas este widget e seus filhos serão reconstruídos em caso de mudança
    return Consumer<OnlineUsersNotifier>(
      builder: (context, onlineUsers, child) {
        // Exibe uma lista de Usuários
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Lista de Usuários (Provider)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10,),
            Expanded(
              child: ListView.builder(
                itemCount: onlineUsers.users.length,
                itemBuilder: (context, index) {
                  final user = onlineUsers.users[index];
                  return UserTile(
                    user: user,
                    // Ao tocar no tile, chamamos o método do Notifier
                    onTap: () => onlineUsers.toggleStatus(user.id),
                  );
                }
              ),
            ),
          ],
        );
      }
    );
  }
}