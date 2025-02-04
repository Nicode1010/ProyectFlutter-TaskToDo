import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // ⚠️ Usa 10.0.2.2 en emuladores de Android, y tu IP local en dispositivos físicos
  static const String baseUrl = "http://127.0.0.1:5000/api";

  // Obtener todas las tareas
  static Future<List<dynamic>> fetchTasks() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/tasks'));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Error al obtener tareas: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  // Agregar una tarea
  static Future<void> addTask(String title) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/tasks'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"title": title}),
      );

      if (response.statusCode != 201) {
        throw Exception('Error al agregar tarea: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  // Eliminar una tarea
  static Future<void> deleteTask(String id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/tasks/$id'));

      if (response.statusCode != 200) {
        throw Exception('Error al eliminar tarea: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}
