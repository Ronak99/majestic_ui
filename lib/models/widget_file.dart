class WidgetFile {
  final String name;
  final String dir;
  final String content;

  WidgetFile({
    required this.name,
    required this.dir,
    required this.content,
  });

  factory WidgetFile.fromJson(Map<String, dynamic> json) {
    return WidgetFile(
      name: json['name'],
      dir: json['dir'],
      content: json['content'],
    );
  }
}
