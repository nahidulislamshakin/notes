class Note{
  String? title;
  String? description;
  Note({required this.title, required this.description});

  // Convert a Note to a Map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
    };
  }

  // Convert a Map to a Note
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
    );
  }
}