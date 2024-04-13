import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/subtask.dart';
import 'package:todo/models/task.dart';
import 'package:todo/providers/task_provider.dart';

class TaskSubTaskListWidget extends StatelessWidget {
  const TaskSubTaskListWidget({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    
    TaskProvider taskProvider = context.watch<TaskProvider>();

    return Column(
      children: [
        taskProvider.isEditing(task.id) ? 
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FilledButton(
              onPressed: () {
                taskProvider.addSubTask(task.id);
              }, 
              child: const Text("Add Subtask")
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  for(String id in task.subtasks)
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: TextField(
                          controller: taskProvider.textControllers[id],
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.zero,
                            constraints: BoxConstraints(
                              maxHeight: 30,
                              maxWidth: 350
                            )
                          ),
                        ),
                      )
                    )
                ],
              ),
            )
          ],
        ): Builder(
          builder:(context) {

            List<Widget> children = [];

            for (var currentSubtask in task.subtasks) {
              SubTask? subtask = taskProvider.getSubTask(currentSubtask);
              
              if (subtask != null) {
                children.add(
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    child: Row(
                      children: [
                        Text(subtask.title),
                        Checkbox(
                          shape: const CircleBorder(),
                          value: getStatus(subtask.taskStatus), 
                          onChanged: (value) {
                            taskProvider.onSubtaskCheckBox(subtask.id);
                          }
                        )
                      ],
                    ),
                  )
                );
              }
            }
            
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            );
          },
          
        )
      ],
    );
  }

  bool? getStatus(SubTaskStatus status) {
    if (status == SubTaskStatus.notDone) {
      return false;
    }
  
    if (status == SubTaskStatus.done) {
      return true;
    }
  
    return null;
  }
}
