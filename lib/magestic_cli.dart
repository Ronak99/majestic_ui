// lib/magestic_cli.dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:magestic_cli/models/widget.dart';
import 'package:path/path.dart' as path;

// dart run bin/magestic_cli.dart add majestic_avatar
class MagesticCli {
  static const String _baseUrl =
      'https://raw.githubusercontent.com/Ronak99/majesticui-flutter/refs/heads/master/all_widgets.json';

  Future<void> add(String widgetName) async {
    try {
      // Fetch widgets
      final allWidgets = await _fetchWidgets();

      // Find requested widget
      final widget = allWidgets.firstWhere(
        (comp) => comp.name == widgetName,
        orElse: () => throw Exception('widget "$widgetName" not found'),
      );

      // Create files
      await _createWidgetsFiles(widget);

      print('✓ Added ${widget.name} widget');

      if (widget.dependencies.isNotEmpty) {
        print('\nThis project following dependencies:');
        print('\n${widget.dependencies.join(' ')}');
        print('\nWould you like to install them? Y/n?');

        // Read user input
        String? response = stdin.readLineSync()?.toLowerCase();

        // If user hits enter (empty response) or 'y', proceed with installation
        if (response == '' || response == 'y') {
          print('Installing dependencies...');

          // Construct the flutter pub add command
          final command = 'flutter';
          final arguments = ['pub', 'add', ...widget.dependencies];

          // Run the command
          final process = await Process.start(command, arguments);

          // Stream the output to console
          await stdout.addStream(process.stdout);
          await stderr.addStream(process.stderr);

          // Wait for the process to complete
          final exitCode = await process.exitCode;

          if (exitCode == 0) {
            print('\n✓ Dependencies installed successfully');
          } else {
            print('\n✗ Failed to install dependencies');
          }
        } else {
          print('Skipped dependency installation');
        }
      }
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  Future<List<Widget>> _fetchWidgets() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch widgets');
    }

    final List<dynamic> jsonData = jsonDecode(response.body);
    return jsonData.map((json) => Widget.fromJson(json)).toList();
  }

  Future<void> _createWidgetsFiles(Widget widget) async {
    for (final file in widget.files) {
      final directory = Directory(file.dir);

      // Create directories if they don't exist
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      // Create file
      final filePath = path.join(file.dir, file.name);
      final widgetFile = File(filePath);
      await widgetFile.writeAsString(file.content);

      print('Created $filePath');
    }
  }
}
