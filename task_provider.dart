import 'package:flutter/material.dart';

class Task {
  String name;
  bool isCompleted;

  Task(this.name, {this.isCompleted = false});
}

class TaskProvider extends ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  List<Task> get completedTasks => _tasks.where((task) => task.isCompleted).toList();

  void addTask(String name) {
    _tasks.add(Task(name));
    notifyListeners();
  }

  void editTask(int index, String newName) {
    _tasks[index].name = newName;
    notifyListeners();
  }

  void toggleTask(int index) {
    _tasks[index].isCompleted = !_tasks[index].isCompleted;
    notifyListeners();
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
    notifyListeners();
  }
}
