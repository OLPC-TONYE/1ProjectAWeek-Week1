class Task {
  String id;
  String title;
  String description;
  DateTime? deadline;
  TaskStatus status;
  TaskResult result;
  List<String> subtasks;

  Task({required this.id, required this.title, required this.description, this.deadline, 
          required this.status, required this.result, required this.subtasks});

  TaskResult get taskResult {

    // if task is done, the result is success
    if (status == TaskStatus.completed) {
      return TaskResult.success;
    }

    if(deadline != null) {
      if (deadline!.difference(DateTime.now()).inMicroseconds < 0 ) {
        return TaskResult.failed;
      }
    }

    return TaskResult.unresolved;
  }

  Task copyWith({String? id, String? title, String? description, DateTime? deadline, TaskStatus? status, TaskResult? result, List<String>? subtasks}) {
    return Task(
      id: id ?? this.id, 
      title: title ?? this.title,
      description: description ?? this.description,
      deadline: deadline ?? this.deadline, 
      status: status ?? this.status, 
      result: result ?? this.result,
      subtasks: subtasks ?? this.subtasks
    );
  }
}

enum TaskStatus {
  completed, uncompleted
}

enum TaskResult {
  failed, success, unresolved
}