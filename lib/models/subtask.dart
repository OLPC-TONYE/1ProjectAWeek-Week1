class SubTask {
  String id;
  String title;
  DateTime? deadline;
  SubTaskStatus taskStatus;

  SubTask({required this.id, this.deadline, required this.taskStatus,  required this.title});
  
  SubTask copyWith({
    String? title, DateTime? deadline, SubTaskStatus? taskStatus
  }) {
    return SubTask(
      id: id, taskStatus: taskStatus ?? this.taskStatus, 
      title: title ?? this.title, deadline: deadline ?? deadline
    );
  }
}

enum SubTaskStatus{
  done, notDone
}