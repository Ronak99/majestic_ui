import 'package:magestic_cli/models/widget_file.dart';

class Widget {
  final String name;
  final List<String> dependencies;
  final List<WidgetFile> files;
  final String type;

  Widget({
    required this.name,
    required this.dependencies,
    required this.files,
    required this.type,
  });

  factory Widget.fromJson(Map<String, dynamic> json) {
    return Widget(
      name: json['name'],
      dependencies: List<String>.from(json['dependencies'] ?? []),
      files: (json['files'] as List)
          .map((file) => WidgetFile.fromJson(file))
          .toList(),
      type: json['type'],
    );
  }
}
