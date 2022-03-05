import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String title;
  final int icon;
  final String color;
  final List<dynamic>? todos;
  const Task({
    required this.color,
    required this.icon,
    required this.title,
    this.todos,
  });
  //How to modify const constructor
  Task copyWith({
    String? title,
    int? icon,
    String? color,
    List<dynamic>? todos,
  }) =>
      Task(
        color: color ?? this.color,
        icon: icon ?? this.icon,
        title: title ?? this.title,
        todos: todos ?? this.todos,
      );
  //json method for api
  factory Task.fromJson(Map<String, dynamic> json) => Task(
        color: json["color"],
        icon: json["icon"],
        title: json["title"],
        todos: json["todos"],
      );
  //
  Map<String, dynamic> toJson() => {
        "title": title,
        "color": color,
        "todos": todos,
        "icon": icon,
      };
  //Equatable araştır
  @override
  // TODO: implement props
  List<Object?> get props => [title, icon, color];
}
