class Task {
  final String id;
  final String title;
  bool isCompleted;

  Task({required this.id, required this.title, this.isCompleted = false});

  // Método para convertir JSON a objeto Task
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['_id'] ?? json['id'], // Asegura compatibilidad con MongoDB
      title: json['title'],
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  // Método para convertir Task a JSON (opcional, si necesitas enviarlo al backend)
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "isCompleted": isCompleted,
    };
  }
}
