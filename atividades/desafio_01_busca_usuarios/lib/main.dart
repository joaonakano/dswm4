import "package:desafio_01_busca_usuarios/viewmodel/provider.viewmodel.dart";
import "package:desafio_01_busca_usuarios/views/provider.view.dart";
import "package:desafio_01_busca_usuarios/views/riverpod.view.dart";

import "package:flutter/material.dart";

import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:provider/provider.dart";

// ===============================================
// PARTE 3: UI DO APLICATIVO (WIDGETS)
// ===============================================

// Widget principal que contém toda a nossa aplicação
void main() {
  runApp(
    // Envolve a aplicação com o ProviderScope para usar o Riverpod
    // É uma boa prática usar ProviderScope mesmo que você use Providers
    ProviderScope(
      child: ChangeNotifierProvider(
        create: (context) => OnlineUsersNotifier(),
        child: MyApp(),
      ),
    ), 
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Status Online',
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Simulador de Status Online"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Usando Provider e Riverpod',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20,),
            // Widget que usa o Provider
            Expanded(child: ProviderView()),
            const SizedBox(height: 20,),
            // Widget que usa o Riverpod
            Expanded(child: RiverpodView()),
          ],
        ),
      ),
    );
  }
}