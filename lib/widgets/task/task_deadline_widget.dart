import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/extensions.dart';
import 'package:todo/models/task.dart';
import 'package:todo/providers/task_provider.dart';

class TaskDeadlineWidget extends StatelessWidget {
  const TaskDeadlineWidget({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {

    TaskProvider taskProvider = context.watch<TaskProvider>();

    return Row(
      children: [
        !taskProvider.isEditing(task.id) ? Text(task.deadline == null ? 'No Deadline' : task.deadline!.fancyDateFormat()) :
        
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: FilledButton(
                onPressed: () async {
                  DateTime currentDate = DateTime.now();
                  
                  DateTime? deadline = await showDatePicker(
                    context: context, 
                    initialDate: currentDate, 
                    firstDate: currentDate, 
                    lastDate: currentDate.add(const Duration(days: 120))
                  );
            
                  if (deadline != null) {
                    taskProvider.addDeadline(task.id, deadline);
                  }
                }, 
                child: Text(taskProvider.editingTasksData[task.id]!['deadline'] == null ? 'Add Deadline' : " ${(taskProvider.editingTasksData[task.id]!['deadline'] as DateTime).fancyDateFormat()}" )
              ),
            ),
            taskProvider.editingTasksData[task.id]!['deadline'] != null ? TextButton(
              onPressed: () async {                        
                DateTime deadline = taskProvider.editingTasksData[task.id]!['deadline'];

                TimeOfDay currentTime = TimeOfDay.now();

                TimeOfDay? time = await showTimePicker(
                  context: context, 
                  initialTime: currentTime,
                );

                if (time != null) {
                  deadline = deadline.add(Duration(hours: time.hour, minutes: time.minute));
                  taskProvider.addDeadline(task.id, deadline);
                }
              }, 
              child: Text((taskProvider.editingTasksData[task.id]!['deadline'] as DateTime).fancyTimeFormat() )
            ): const SizedBox()
          ],
        ),
        
      ],
    );
  }
}
