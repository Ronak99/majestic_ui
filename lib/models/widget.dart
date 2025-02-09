import 'package:majestic_ui/models/widget_file.dart';

class Widget {
  final String name;
  final List<String> dependencies;
  final List<WidgetFile> files;

  Widget({
    required this.name,
    required this.dependencies,
    required this.files,
  });

  factory Widget.fromJson(Map<String, dynamic> json) {
    return Widget(
      name: json['name'],
      dependencies: List<String>.from(json['dependencies'] ?? []),
      files: (json['files'] as List)
          .map((file) => WidgetFile.fromJson(file))
          .toList(),
    );
  }
}
