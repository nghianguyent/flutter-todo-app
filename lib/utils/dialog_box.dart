import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do_app/my_button.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow,
      title: const Text('Add Todo'),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(hintText: 'Enter your todo'),
      ),
      actions: [
        MyButton(
          onPressed: onCancel,
          text: 'Cancel',
        ),
        MyButton(
          onPressed: onSave,
          text: 'Add',
        ),
      ],
    );
  }
}
