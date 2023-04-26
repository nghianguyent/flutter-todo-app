import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_app/data/database.dart';
import 'package:to_do_app/utils/dialog_box.dart';
import 'package:to_do_app/utils/todo_title.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  // reference the box
  final _mybox = Hive.box('todo');
  ToDoDatabase db = ToDoDatabase();

  // init state whenever the app is opened then create default data
  @override
  void initState() {
    if (_mybox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  void checkboxChange(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = value!;
    });
    db.updateData();
  }

  void onSave() {
    setState(
      () {
        db.todoList.add([_controller.text, false]);
        _controller.clear();
        Navigator.pop(context);
      },
    );
    db.updateData();
  }

  void addTodo() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: onSave,
          onCancel: () => Navigator.pop(context),
        );
      },
    );
    db.updateData();
  }

  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateData();
  }

  void editTask(int index) {
    _controller.text = db.todoList[index][0];
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: onSave,
          onCancel: () => {
            _controller.clear(),
            Navigator.pop(context),
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[200],
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Todo List',
        ),
      ),
      body: ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder: (context, index) => TodoTitle(
          taskName: db.todoList[index][0],
          isDone: db.todoList[index][1],
          onChanged: (value) => checkboxChange(value, index),
          deleteAction: (context) => deleteTask(index),
          editAction: (context) => editTask(index),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addTodo,
        child: const Icon(Icons.add),
      ),
    );
  }
}
