class NoteModel {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime? updatedAt;
  
  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    this.updatedAt,
  });
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'content': content,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
  };
  
  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
    id: json['id'],
    title: json['title'],
    content: json['content'],
    createdAt: DateTime.parse(json['createdAt']),
    updatedAt: json['updatedAt'] != null 
        ? DateTime.parse(json['updatedAt']) 
        : null,
  );
}

