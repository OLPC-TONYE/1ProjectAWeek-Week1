import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/subtask.dart';
import 'package:todo/models/task.dart';
import 'package:todo/providers/task_provider.dart';

import 'deadline_countdown.dart';
import 'task_deadline_widget.dart';
import 'task_description_widget.dart';
import 'task_subtask_list_widget.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    
    TaskProvider taskProvider = context.watch<TaskProvider>();

    return Row(
      
      children: [
        Expanded(
          child: Card(
            child: ListTile(
              title: Row(
                children: [
                  Flexible(
                    child: TaskTitleWidget(task: task),
                  ),
                  
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TaskDeadlineWidget(task: task),
                  TaskDescriptionWidget(task: task),
                  TaskSubTaskListWidget(task: task),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        task.taskResult != TaskResult.unresolved ? task.taskResult == TaskResult.success ? "Success" :
                        "Failed" : "UnResolved", 
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 140,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                shape: const CircleBorder(),
                value: getStatus(task.status), 
                onChanged: !taskProvider.isEditing(task.id) ? (value) {
                  taskProvider.onTaskCheckBox(task.id);
                } : null
              ),
              !taskProvider.isEditing(task.id) ? task.taskResult != TaskResult.success ? task.deadline != null ? 
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DeadlineCountdown(task: task),
                  const Text("till deadline", style: TextStyle(fontSize: 11),)
                ],
              ) : Text("No deadline", style: TextStyle(fontSize: 11)) : SizedBox() : const SizedBox(),
            ],
          ),
        )
      ],
    );

  }

  bool? getStatus(TaskStatus status) {
    if (status == TaskStatus.uncompleted) {
      return false;
    }
  
    if (status == TaskStatus.completed) {
      return true;
    }
  
    return null;
  }
}

class TaskTitleWidget extends StatelessWidget {
  const TaskTitleWidget({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {

    TaskProvider taskProvider = context.watch<TaskProvider>();

    return Row(
      children: [
        !taskProvider.isEditing(task.id) ? Text(task.title) : 
          Flexible(
            child: TextField(
              controller: taskProvider.editingTasksData[task.id]!['title'],
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(2),
                constraints: BoxConstraints(
                  maxHeight: 32,
                  maxWidth: 320
                )
              ),
            )
          ),
        IconButton(
          onPressed: (){
            taskProvider.deleteTask(task.id);
          }, 
          icon: const Icon(Icons.delete)
        ),
        IconButton(
          onPressed: (){                
            taskProvider.toggleEditMode(task.id);
          }, 
          icon: !taskProvider.isEditing(task.id) ? const Icon(Icons.edit) : const Icon(Icons.check)
        ),
        
      ],
    );
  }
}
