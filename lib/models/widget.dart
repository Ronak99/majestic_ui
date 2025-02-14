import 'package:majestic_ui/models/widget_file.dart';

class Widget {
  final String name;
  final List<String> dependencies;
  final List<WidgetFile> files;
  final String status;

  Widget({
    required this.name,
    required this.dependencies,
    required this.files,
    required this.status,
  });

  factory Widget.fromJson(Map<String, dynamic> json) {
    return Widget(
      name: json['name'],
      dependencies: List<String>.from(json['dependencies'] ?? []),
      files: (json['files'] as List)
          .map((file) => WidgetFile.fromJson(file))
          .toList(),
      status: json.containsKey('registry')
          ? json['registry']['status']
          : 'rejected',
    );
  }

  bool get isApproved => status == "approved";
  bool get isRejected => status == "rejected";
  bool get isUnderReview => status == "under_review";
}
