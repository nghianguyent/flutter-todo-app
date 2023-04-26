import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTitle extends StatelessWidget {
  final String taskName;
  final bool isDone;
  Function(bool?) onChanged;
  Function(BuildContext?) deleteAction;
  Function(BuildContext?) editAction;

  TodoTitle({
    super.key,
    required this.taskName,
    required this.isDone,
    required this.onChanged,
    required this.deleteAction,
    required this.editAction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 12),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteAction,
              icon: Icons.delete,
              backgroundColor: Colors.red,
            ),
            SlidableAction(
              onPressed: editAction,
              icon: Icons.edit,
              backgroundColor: Colors.amber,
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.yellow,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(2, 2),
              ),
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(2, 4),
              ),
            ],
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Title
              Text(
                taskName,
                style: TextStyle(
                  fontSize: 18,
                  decoration: isDone ? TextDecoration.lineThrough : null,
                ),
              ),
              // check box
              Checkbox(
                value: isDone,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
