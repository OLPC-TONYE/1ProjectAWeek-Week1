import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task.dart';
import 'package:todo/providers/task_provider.dart';

class TaskDescriptionWidget extends StatelessWidget {
  const TaskDescriptionWidget({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {

    TaskProvider taskProvider = context.watch<TaskProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          !taskProvider.isEditing(task.id) ? Text(task.description) : 
          Flexible(
            child: TextField(
              controller: taskProvider.editingTasksData[task.id]!['description'],
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(5),
                constraints: BoxConstraints(
                  maxHeight: 30,
                  maxWidth: 340
                )
              ),
              minLines: 2,
              maxLines: 4,
            )
          ),
        ],
      ),
    );
  }
}
