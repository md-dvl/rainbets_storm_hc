class GroupModel {
  final String id;
  final String name;
  final String city;
  final String description;
  final String sport;
  final DateTime createdAt;
  
  GroupModel({
    required this.id,
    required this.name,
    required this.city,
    required this.description,
    required this.sport,
    required this.createdAt,
  });
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'city': city,
    'description': description,
    'sport': sport,
    'createdAt': createdAt.toIso8601String(),
  };
  
  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
    id: json['id'],
    name: json['name'],
    city: json['city'],
    description: json['description'],
    sport: json['sport'],
    createdAt: DateTime.parse(json['createdAt']),
  );
}

