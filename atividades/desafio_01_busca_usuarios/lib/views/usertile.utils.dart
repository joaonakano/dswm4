// Widget reutilizável para exibir cada usuário na lista
import 'package:desafio_01_busca_usuarios/models/user.model.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final User user;
  final VoidCallback onTap;
  
  const UserTile({
    required this.user,
    required this.onTap,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(user.name),
        subtitle: Text(user.isOnline ? 'Online' : 'Offline'),
        leading: CircleAvatar(
          backgroundColor: user.isOnline ?  Colors.green : Colors.grey,
        ),
        onTap: onTap,
      ),
    );
  }
}