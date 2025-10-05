import 'package:aula_30_09_2025_gerenciamento_de_estados_avancado/models/task.dart';
import 'package:flutter/foundation.dart';

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTask(String titulo) {
    _tasks.add(
      Task(
        id: DateTime.now().toString(),
        titulo: titulo,
      ),
    );

    notifyListeners();
  }

  void finishTask(String id) {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    _tasks[taskIndex].isCompleted = !_tasks[taskIndex].isCompleted;
    notifyListeners();
  }

  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }
}