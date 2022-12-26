import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_taskapp/app/data/models/task.dart';
import 'package:flutter_taskapp/app/data/services/storage/repository.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;
  HomeController({required this.taskRepository});
  final formKey = GlobalKey<FormState>();
  final editCtrl = TextEditingController();
  final tabIndex = 0.obs;
  final chipIndex = 0.obs;
  final deleting = false.obs;
  final tasks = <Task>[].obs;
  final task = Rx<Task?>(null);
  final doingTodos = <dynamic>[].obs;
  final doneTodos = <dynamic>[].obs;
  // var tan = DateTime;
  final tanggal = DateTime.now();
  // final List<Task> _tasks = [];
  // final TextEditingController tanggal = TextEditingController();

  // get context => '';
  // DateTime now = DateTime.now();

  // final items = <DateTime>[];

  // set items(List<DateTime> items) {}

  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTasks());
    ever(tasks, (_) => taskRepository.writeTasks(tasks));
  }

  @override
  void onClose() {
    editCtrl.dispose();
    super.onClose();
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  void changeChipIndex(int value) {
    chipIndex.value = value;
  }

  void changeDeleting(bool value) {
    deleting.value = value;
  }

  void changeTask(Task? select) {
    task.value = select;
  }

  void changeTodos(List<dynamic> select) {
    doingTodos.clear();
    doneTodos.clear();
    for (int i = 0; i < select.length; i++) {
      var todo = select[i];
      var status = todo['done'];
      if (status == true) {
        doneTodos.add(todo);
      } else {
        doingTodos.add(todo);
      }
    }
  }

  bool addTask(Task task) {
    if (tasks.contains(task)) {
      return false;
    }
    tasks.add(task);
    return true;
  }

  void deleteTask(Task task) {
    tasks.remove(task);
  }

  updateTask(Task task, String title, String tanggal) {
    var todos = task.todos ?? [];
    if (containerTodo(todos, title, tanggal)) {
      return false;
    }
    var todo = {'title': title, 'tanggal': tanggal, 'done': false};
    todos.add(todo);
    var newTask = task.copyWith(todos: todos);
    int oldIdx = tasks.indexOf(task);
    tasks[oldIdx] = newTask;
    tasks.refresh();
    return true;
  }

  bool containerTodo(List todos, String title, String dateFormat) {
    return todos.any((element) => element['title']['tanggal'] == title);
  }

  bool addTodo(String title, String tanggal) {
    var todo = {'title': title, 'tanggal': tanggal, 'done': false};
    if (doingTodos
        .any((element) => mapEquals<String, dynamic>(todo, element))) {
      return false;
    }
    var doneTodo = {'title': title, 'tanggal': tanggal, 'done': true};
    if (doneTodos
        .any((element) => mapEquals<String, dynamic>(doneTodo, element))) {
      return false;
    }
    doingTodos.add(todo);
    return true;
  }

  // getcalender(date) async {
  //   //   TextFormField(
  //   //     // controller: tanggal,
  //   //     decoration: const InputDecoration(
  //   //         // border: OutlineInputBorder(),
  //   //         // borderSide: BorderSide(color: Colors.grey[400]!),

  //   //         icon: Icon(Icons.calendar_today), //icon of text field
  //   //         labelText: "Enter Date"),
  //   //     readOnly: true,
  //   //     //    validator: (value) {
  //   //     //   if (value == null || value.trim().isEmpty) {
  //   //     //     return 'Please enter your date';
  //   //     //   }
  //   //     //   return null;
  //   //     // },

  //   //     onTap: () async {
  //   DateTime? pickDate = await showDatePicker(
  //       context: context,
  //       initialDate: DateTime.now(),
  //       firstDate: DateTime(2000),
  //       lastDate: DateTime(2100));
  //   if (pickDate != null) {
  //     // ignore: non_constant_identifier_names, unused_element
  //     SetState() {
  //       tanggal.text = pickDate.toString();
  //     }
  //   } else {
  //     print('Please enter your date');
  //   }
  //   //     },
  //   //   );
  //   // }
  // }

  getFormatedDate() {
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    var sv = [date][0];

    // 2016-01-25

    // if (sv != tanggal) {
    //   DateTime baru = new DateTime.now();
    //   DateTime datenew = new DateTime(
    //       baru.year, baru.month, baru.day, baru.hour, baru.minute, baru.second);
    //   return datenew;
    // } else {
    return sv;
    // }

    // DateTime date = new DateTime(berlinWallFell.year, berlinWallFell.month,
    //     berlinWallFell.day, moonLanding.hour, moonLanding.minute); // 18
    // DateTime now = new DateTime.now();
    // DateTime date = new DateTime(now.year, now.month, now.day);
    // final now = DateTime.now();
    // final berlinWallFell = DateTime.utc(1989, 11, 9);
    // final moonLanding = DateTime.parse('1969-07-20 20:18:04Z');

    // if (task == DateTime.now()) {
    //   return date;
    // } else {
    //   DateTime baru = new DateTime.now();
    //   DateTime datenew = new DateTime(baru.year, baru.month, baru.day);
    //   return datenew;
  }

  void updateTodos() {
    var newTodos = <Map<String, dynamic>>[];
    newTodos.addAll([
      ...doingTodos,
      ...doneTodos,
    ]);
    var newTask = task.value!.copyWith(todos: newTodos);
    int oldIdx = tasks.indexOf(task.value);
    tasks[oldIdx] = newTask;
    tasks.refresh();
  }

  void doneTodo(String title, String tanggal) {
    var doingTodo = {'title': title, 'tanggal': tanggal, 'done': false};
    int index = doingTodos.indexWhere(
        (element) => mapEquals<String, dynamic>(doingTodo, element));
    doingTodos.removeAt(index);
    var doneTodo = {'title': title, 'tanggal': tanggal, 'done': true};
    doneTodos.add(doneTodo);
    doingTodos.refresh();
    doneTodos.refresh();
  }

  void exptodo() {
    doingTodos.forEach((elementloop) {
      if (elementloop['tanggal'] != getFormatedDate().toString()) {
        doingTodos.removeAt(doingTodos.indexWhere(
            (element) => mapEquals<String, dynamic>(elementloop, element)));
        doingTodos.refresh();
      }
    });
    //   var doingTodoexptodo = {'title': title, 'tanggal': getFormatedDate() 'done': true};
    //   int indexexp = doingTodos.indexWhere(
    //       (element) => !mapEquals<String, dynamic>(doingTodoexptodo, element));
  }

  void exptododone() {
    doneTodos.forEach((elementloopdone) {
      if (elementloopdone['tanggal'] != getFormatedDate().toString()) {
        doneTodos.removeAt(doneTodos.indexWhere(
            (element) => mapEquals<String, dynamic>(elementloopdone, element)));
        doneTodos.refresh();
      }
    });
  }

  deleteDoneTodo(dynamic doneTodo) {
    int index = doneTodos
        .indexWhere((element) => mapEquals<String, dynamic>(doneTodo, element));
    doneTodos.removeAt(index);
    doneTodos.refresh();
  }

  bool isTodosEmpty(Task task) {
    return task.todos == null || task.todos!.isEmpty;
  }

  int getDoneTodo(Task task) {
    var res = 0;
    for (int i = 0; i < task.todos!.length; i++) {
      if (task.todos![i]['done'] == true) {
        res += 1;
      }
    }
    return res;
  }

  int getTotalTask() {
    var res = 0;
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].todos != null) {
        res += tasks[i].todos!.length;
      }
    }
    return res;
  }

  int getTotalDoneTask() {
    var res = 0;
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].todos != null) {
        for (int j = 0; j < tasks[i].todos!.length; j++) {
          if (tasks[i].todos![j]['done'] == true) {
            res += 1;
          }
        }
      }
    }
    return res;
  }
}
