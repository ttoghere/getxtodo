import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxtodo/app/core/utils/keys.dart';
import 'package:getxtodo/app/data/models/task.dart';
import 'package:getxtodo/app/data/services/services.dart';

class TaskProvider with ChangeNotifier {
  final StorageService storageService = Get.find<StorageService>();
  List<Task> readTasks() {
    var tasks = <Task>[];
    //json to String for incoming data == jsonDecode
    jsonDecode(storageService.read(taskKey).toString())
        .forEach((element) => element.add<String,dynamic>(Task.fromJson(element)));
    return tasks;
  }

  void writeTasks(List<Task> tasks) {
    storageService.write(taskKey, jsonEncode(tasks));
  }
}
