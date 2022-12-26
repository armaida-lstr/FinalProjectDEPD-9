import 'package:equatable/equatable.dart';

// DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
// String string = dateFormat.format(DateTime.now());

class Task extends Equatable {
  final String title;
  final int icon;
  final String color;
  final String tanggal;
  // final List<DateTime>? items;
  final List<dynamic>? todos;

  const Task({
    required this.title,
    required this.icon,
    required this.color,
    required this.tanggal,
    this.todos,
  });

  Task copyWith({
    String? title,
    int? icon,
    String? color,
    String? tanggal,
    // List<DateTime>? items,
    List<dynamic>? todos,
  }) =>
      Task(
        title: title ?? this.title,
        icon: icon ?? this.icon,
        color: color ?? this.color,
        tanggal: tanggal ?? this.tanggal,
        todos: todos ?? this.todos,
      );

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        title: json['title'],
        icon: json['icon'],
        color: json['color'],
        tanggal: json['tanggal'].toString(),
        todos: json['todos'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'icon': icon,
        'color': color,
        'tanggal': tanggal,
        'todos': todos,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [title, icon, tanggal, color];
}
