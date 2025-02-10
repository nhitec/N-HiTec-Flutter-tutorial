class Note {
  int? id;
  String title;
  String? content;
  final DateTime creationDate;
  DateTime editionDate;

  Note({
    this.id,
    required this.title,
    this.content,
    required this.creationDate,
    DateTime? editionDate,
  }) : editionDate = editionDate ?? creationDate;

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'content': content,
      'creationDate': creationDate.millisecondsSinceEpoch,
      'editionDate': editionDate.millisecondsSinceEpoch,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      creationDate: DateTime.fromMillisecondsSinceEpoch(map['creationDate']),
      editionDate: DateTime.fromMillisecondsSinceEpoch(map['editionDate']),
    );
  }
}
