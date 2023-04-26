import 'package:hive/hive.dart';

class ToDoDatabase {
  List todoList = [];

  // reference the box
  final _myhive = Hive.box('todo');

  // run this every time open the app
  void createInitialData() {
    todoList = [
      ['Task 1', false],
      ['Task 2', true],
    ];
  }

  void loadData() {
    todoList = _myhive.get('TODOLIST');
  }

  void updateData() {
    _myhive.put("TODOLIST", todoList);
  }
}
