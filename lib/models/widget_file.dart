class WidgetFile {
  final String name;
  final String filepath;
  final String content;

  WidgetFile({
    required this.name,
    required this.filepath,
    required this.content,
  });

  factory WidgetFile.fromJson(Map<String, dynamic> json) {
    return WidgetFile(
      name: json['name'],
      filepath: json['file_path'],
      content: json['content'],
    );
  }
}
