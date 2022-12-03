import 'dart:convert';

class Link {
  final int id;
  final String name;
  final String description;
  final String url;
  final int clicks;

  Link({
    required this.id,
    required this.name,
    required this.description,
    required this.url,
    required this.clicks,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'url': url,
      'clicks': clicks,
    };
  }

  factory Link.fromMap(Map<String, dynamic> map) {
    return Link(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      url: map['url'] ?? '',
      clicks: map['clicks']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Link.fromJson(String source) => Link.fromMap(json.decode(source));

  Link copyWith({
    int? id,
    String? name,
    String? description,
    String? url,
    int? clicks,
  }) {
    return Link(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      url: url ?? this.url,
      clicks: clicks ?? this.clicks,
    );
  }
}
