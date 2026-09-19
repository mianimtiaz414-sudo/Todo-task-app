class TaskModel {
  final String title;
  final String description;
  final String category;
  final String dateKey;

  TaskModel({
    required this.title,
    required this.description,
    required this.category,
    required this.dateKey,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'dateKey': dateKey,
    };
  }

  factory TaskModel.fromMap(Map<dynamic, dynamic> map) {
    return TaskModel(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      dateKey: map['dateKey'] ?? '',
    );
  }
}
