import 'package:flutter/material.dart';
import 'package:todo/models/subtask.dart';

import 'package:todo/models/task.dart';

class TaskProvider extends ChangeNotifier{


  List<Task> tasks = [];
  List<SubTask> subtasks = [];

  List<String> editingTasks = [];
  Map<String, Map<String, dynamic>> editingTasksData = {};
  Map<String, TextEditingController> textControllers = {};

  Future<List<Task>> fetchTasks () async {
    return tasks;
  }

  void addTask(Task task) {
    tasks.add(task);
    notifyListeners();
  }

  void deleteTask(String id) {
    tasks.removeWhere((task) => task.id == id);
    editingTasksData.remove(id);
    editingTasks.remove(id);
    notifyListeners();
  }

  bool isEditing(String id) {
    return editingTasks.contains(id);
  }

  void addDeadline(String id, DateTime deadline) {
    if(editingTasks.contains(id)) {
      editingTasksData[id]?['deadline'] = deadline;
    }
    notifyListeners();
  }

  void addSubTask(String id) {
    if(editingTasks.contains(id)) {
      String subTaskId = 'sub${4200 + subtasks.length}';
      var currentSubtask = SubTask(id: subTaskId, taskStatus: SubTaskStatus.notDone, title: "title");
      subtasks.add(currentSubtask);
      (editingTasksData[id]!['subtasks'] as List<String> ).add(subTaskId);
      textControllers[subTaskId] = TextEditingController(text: currentSubtask.title);
    }
    notifyListeners();
  }

  void toggleEditMode(String id) {
    Task task = tasks.singleWhere((element) => element.id == id);
    if(editingTasks.contains(id)) {
      onTaskEdit(id, 
        task.copyWith(
          title: editingTasksData[task.id]!['title']?.text, 
          description: editingTasksData[task.id]!['description']?.text,
          deadline: editingTasksData[task.id]!['deadline'],
          subtasks: editingTasksData[task.id]!['subtasks'],
        )  
      );

      for (var subtask in task.subtasks) {
        SubTask? currentSubtask = getSubTask(subtask);
        if (currentSubtask != null) {
          onSubTaskEdit(subtask, currentSubtask.copyWith(
            title: textControllers[subtask]!.text
          ));
          textControllers.remove(subtask);
        }
      }
      editingTasksData.remove(id);
      editingTasks.remove(id);
    }else {
      editingTasks.add(id);
      editingTasksData[id] = {
        'title' : TextEditingController(text: task.title),
        'description' : TextEditingController(text: task.description),
        'deadline' : task.deadline,
        'subtasks' : task.subtasks,
      };

      for (var subtask in task.subtasks) {
        SubTask? currentSubtask = getSubTask(subtask);
        if (currentSubtask != null) {
          textControllers[subtask] = TextEditingController(text: currentSubtask.title);
        }
      }
      
    }
    notifyListeners();
  }

  void onTaskCheckBox(String id){
    int index = tasks.indexWhere((task) => task.id == id);
    Task task = tasks[index];
    if (task.status == TaskStatus.uncompleted) {
      tasks[index] = task.copyWith(status: TaskStatus.completed);
    }else if (task.status == TaskStatus.completed) {
      tasks[index] = task.copyWith(status: TaskStatus.uncompleted);
    }
    notifyListeners();
  }

  void onSubtaskCheckBox(String id){
    int index = subtasks.indexWhere((task) => task.id == id);
    SubTask task = subtasks[index];
    if (task.taskStatus == SubTaskStatus.notDone) {
      subtasks[index] = task.copyWith(taskStatus: SubTaskStatus.done);
    }else if (task.taskStatus == SubTaskStatus.done) {
      subtasks[index] = task.copyWith(taskStatus: SubTaskStatus.notDone);
    }
    notifyListeners();
  }

  void onTaskEdit(String id, Task task) {
    int index = tasks.indexWhere((task) => task.id == id);
    tasks[index] = task;
    notifyListeners();
  }

  void onSubTaskEdit(String id, SubTask task, {bool? listen}) {
    int index = subtasks.indexWhere((task) => task.id == id);
    subtasks[index] = task;
    if (listen == null) {
      notifyListeners();
    }
  }

  SubTask? getSubTask(String id) {
    if(subtasks.where((element) => element.id == id).isNotEmpty) {
      return subtasks.singleWhere((element) => element.id == id);
    }

    return null;
  }
}