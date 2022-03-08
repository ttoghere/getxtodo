import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxtodo/app/data/models/task.dart';
import 'package:getxtodo/app/data/storage/repository.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;
  HomeController({
    required this.taskRepository,
  });
  final tasks = <Task>[].obs;
  final formKey = GlobalKey<FormState>();
  final editCtrl = TextEditingController();
  final chipIndex = 0.obs;
  final deleting = false.obs;
  final task = Rx<Task?>(null);
  final doingTodos = <dynamic>[].obs;
  final doneTodos = <dynamic>[].obs;
  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTasks());
    ever(tasks, (callback) => taskRepository.writeTasks(tasks));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeDeleting(bool value) {
    deleting.value = value;
  }

  bool addTask(Task task) {
    if (tasks.contains(task)) {
      return false;
    }
    tasks.add(task);
    return true;
  }

  void changeTask(Task? select) {
    task.value = select;
  }

  void changeChipIndex(int value) {
    chipIndex.value = value;
  }

  void deleteTask(Task task) {
    tasks.remove(task);
  }

  void changeTodos(List<dynamic> select) {
    doingTodos.clear();
    doneTodos.clear();
    for (int i = 0; i < select.length; i++) {
      var todo = select[i];
      var status = todo["done"];
      if (status == true) {
        doneTodos.add(todo);
      } else {
        doingTodos.add(todo);
      }
    }
  }

  updateTask(Task task, String title) {
    var todos = task.todos ?? [];
    if (containeTodo(todos, title)) {
      return false;
    }
    var todo = {"title": title, "done": false};
    todos.add(todo);
    var newTask = task.copyWith(todos: todos);
    int oldIdx = tasks.indexOf(task);
    tasks[oldIdx] = newTask;
    tasks.refresh();
    return true;
  }
}

bool containeTodo(List todos, String title) {
  return todos.any((element) => element["title"] == title);
}
