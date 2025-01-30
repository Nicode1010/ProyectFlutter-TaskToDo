import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/task_tile.dart';
import 'add_task_screen.dart'; // Importamos la pantalla para agregar tareas

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [
    Task(id: '1', title: 'Aprender Flutter'),
    Task(id: '2', title: 'Hacer ejercicio'),
    Task(id: '3', title: 'Leer un libro'),
  ];

  void toggleTask(String id) {
    setState(() {
      Task task = tasks.firstWhere((task) => task.id == id);
      task.isCompleted = !task.isCompleted;
    });
  }

  void deleteTask(String id) {
    setState(() {
      tasks.removeWhere((task) => task.id == id);
    });
  }

  void addTask(String title) {
    setState(() {
      tasks.add(Task(id: DateTime.now().toString(), title: title));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('To-Do List')),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Dismissible(
            key: Key(task.id),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              deleteTask(task.id);
            },
            child: TaskTile(task: task, toggleTask: toggleTask, deleteTask: deleteTask),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => AddTaskScreen(addTask: addTask),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
