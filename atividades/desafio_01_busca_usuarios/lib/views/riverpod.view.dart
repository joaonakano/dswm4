import 'package:desafio_01_busca_usuarios/main.dart';
import 'package:desafio_01_busca_usuarios/models/user.model.dart';
import 'package:desafio_01_busca_usuarios/views/usertile.utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ===============================================
// WIDGETS DE VISUALIZAÇÃO (RIVERPOD)
// ===============================================

// Widget que consome o estado usando o pacote 'flutter_riverpod'
class RiverpodView extends ConsumerStatefulWidget {
  const RiverpodView({super.key});

  @override
  ConsumerState<RiverpodView> createState() => _RiverpodViewState();
}

class _RiverpodViewState extends ConsumerState<RiverpodView> {
  final TextEditingController _searchController = TextEditingController();
  List<User> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text;
    
    final List<User> result = ref.read(onlineUsersNotifierProvider.notifier).filterUsers(query);

    setState(() {
      _filteredItems = result;
    });
  }

  // Usa o 'ref' para interagir com os Providers
  @override
  Widget build(BuildContext context) {
    // Usamos ref.watch para escutar o provider
    // Isso fará que o widget seja reconstruído em caso de mudança do estado
    final users = ref.watch(onlineUsersNotifierProvider);

    final List<User> displayList = _searchController.text.isEmpty ? users : _filteredItems;
    final bool noResults = _searchController.text.isNotEmpty && _filteredItems.isEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Lista de Usuários (Riverpod)",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10,),
        // Criação da Barra de pesquisa
        SizedBox(
          width: 300,
          child: TextField(
            decoration: InputDecoration(
              label: Text("Pesquisa de Usuário"),
              hint: Text("João Nakano"),
              prefixIcon: Icon(Icons.search),
            ),
            controller: _searchController,
          ),
        ),
        const SizedBox(height: 10,),
        
        // Exibe mensagem de sem resultados
        if (noResults)
          Align(
            alignment: Alignment.centerLeft,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Nenhum usuário encontrado.",
                style: TextStyle(fontStyle: FontStyle.italic, color: Colors.red),
              ),
            ),
          )
        else
          Expanded(
            child: ListView.builder(
              itemCount: displayList.length,
              itemBuilder: (context, index) {
                final user = displayList[index];
                return UserTile(
                  user: user,
                  // Chamamos o método do notifier através do 'ref.read'
                  // Usamos 'read' aqui pois não precisamos que o widget seja reconstruído apenas por conta do método
                  onTap: () => ref.read(onlineUsersNotifierProvider.notifier).toggleStatus(user.id),
                );
              },
            ),
          ),
      ],
    );
  }
}