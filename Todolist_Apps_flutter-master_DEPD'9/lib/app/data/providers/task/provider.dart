import 'dart:convert';

import 'package:flutter_taskapp/app/core/utils/keys.dart';
import 'package:flutter_taskapp/app/data/models/task.dart';
import 'package:flutter_taskapp/app/data/services/storage/services.dart';
import 'package:get/get.dart';

class TaskProvider {
  final _storage = Get.find<StorageService>();

// {
//   'tasks': [
//     {'title': 'Work',
//     'color': '#ff123456',
//     'icon': 0xe123}
//   ]
// }

  List<Task> readTasks() {
    var tasks = <Task>[];
    jsonDecode(_storage.read(taskKey).toString())
        .forEach((e) => tasks.add(Task.fromJson(e)));
    return tasks;
  }

  void writeTasks(List<Task> tasks) {
    _storage.write(taskKey, jsonEncode(tasks));
  }
}
