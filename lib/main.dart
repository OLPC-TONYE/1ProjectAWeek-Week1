import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/task_provider.dart';

import 'widgets/task/task_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        filledButtonTheme: const FilledButtonThemeData(
          style: ButtonStyle(
            padding: MaterialStatePropertyAll( EdgeInsets.all(5)),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))))
          )
        )
      ),
      home: ChangeNotifierProvider(
        create: (context) => TaskProvider(),
        child: const TasksListView()),
    );
  }
}

class TasksListView extends StatefulWidget {
  const TasksListView({super.key});

  @override
  State<TasksListView> createState() => _TasksListViewState();
}

class _TasksListViewState extends State<TasksListView> {

  @override
  Widget build(BuildContext context) {

    TaskProvider taskProvider = context.watch<TaskProvider>();

    var tasks = taskProvider.tasks;
    

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("To Do App"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, itemCount) {

                  Task task = tasks[itemCount];
                  return TaskWidget(task: task);
                }
              )
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                child: const Text("Add"),
                onPressed: () {

                  taskProvider.addTask(
                    Task(
                      id: "taskt${4200 + tasks.length}", 
                      title: "New Task ${tasks.isNotEmpty ? tasks.length : ''}",
                      description: "No Description", 
                      deadline: null, 
                      status: TaskStatus.uncompleted, 
                      result: TaskResult.unresolved,
                      subtasks: []
                    )
                  );
                }
              )
            ],
          )
        ],
      ),
    );
  }
}
