import 'package:flutter/material.dart';

class AddTaskScreen extends StatelessWidget {
  final Function(String) addTask;

  AddTaskScreen({required this.addTask});

  @override
  Widget build(BuildContext context) {
    String newTaskTitle = "";

    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            onChanged: (value) {
              newTaskTitle = value;
            },
            decoration: InputDecoration(labelText: "Nueva tarea"),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              if (newTaskTitle.isNotEmpty) {
                addTask(newTaskTitle);
                Navigator.pop(context);
              }
            },
            child: Text("Agregar"),
          )
        ],
      ),
    );
  }
}
