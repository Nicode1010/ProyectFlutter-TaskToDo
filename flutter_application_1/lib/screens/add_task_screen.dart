import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  final Function(String) addTask;

  AddTaskScreen({required this.addTask});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: 'Nueva tarea'),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              String newTaskTitle = _controller.text;
              if (newTaskTitle.isNotEmpty) {
                widget.addTask(newTaskTitle);
                Navigator.pop(context); // Cerrar modal
              }
            },
            child: Text('Agregar tarea'),
          ),
        ],
      ),
    );
  }
}
