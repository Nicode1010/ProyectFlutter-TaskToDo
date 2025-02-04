import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/api_service.dart'; // Importamos el servicio de API
import '../widgets/task_tile.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks(); // Cargar tareas desde la API al iniciar
  }

  Future<void> _loadTasks() async {
    try {
      final fetchedTasks = await ApiService.fetchTasks();
      setState(() {
        tasks = fetchedTasks.map((task) => Task.fromJson(task)).toList();
      });
    } catch (e) {
      print('Error al cargar tareas: $e');
    }
  }

  Future<void> _addTask(String title) async {
    try {
      await ApiService.addTask(title);
      _loadTasks(); // Recargar la lista desde la API
    } catch (e) {
      print('Error al agregar tarea: $e');
    }
  }

  Future<void> _deleteTask(String id) async {
    try {
      await ApiService.deleteTask(id);
      _loadTasks(); // Recargar la lista después de eliminar
    } catch (e) {
      print('Error al eliminar tarea: $e');
    }
  }

  void toggleTask(String id) {
    setState(() {
      Task task = tasks.firstWhere((task) => task.id == id);
      task.isCompleted = !task.isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('To-Do List')),
      body: tasks.isEmpty
          ? Center(child: CircularProgressIndicator()) // Muestra un loader si no hay tareas aún
          : ListView.builder(
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
                    _deleteTask(task.id);
                  },
                  child: TaskTile(task: task, toggleTask: toggleTask, deleteTask: _deleteTask),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => AddTaskScreen(addTask: _addTask),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
