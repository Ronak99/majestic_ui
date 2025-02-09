// lib/magestic_cli.dart
import 'dart:convert';
import 'dart:io';
import 'package:chalkdart/chalkdart.dart';
import 'package:http/http.dart' as http;
import 'package:interact_cli/interact_cli.dart';
import 'package:majestic_ui/models/widget.dart';
import 'package:path/path.dart' as path;

// add welcome_page auth_page landing_page categories_page animated_button avatar

class MagesticCli {
  static const String _baseUrl = 'http://localhost:3000/api/registry';
  Chalk error = chalk.bold.red;
  Chalk warning = chalk.keyword('orange');
  Chalk success = chalk.greenBright;

  Future<void> add(List<String> requestedComponents) async {
    try {
      // Fetch widgets
      final gift = Spinner(
        icon: '🏆',
        leftPrompt: (done) => '',
        rightPrompt: (state) => switch (state) {
          SpinnerStateType.inProgress => 'Processing...',
          SpinnerStateType.done => 'Done!',
          SpinnerStateType.failed => 'Failed!',
        },
      ).interact();

      final widgets = await _fetchWidgets(requestedComponents);

      gift.done();

      // Create Widget Files
      for (Widget w in widgets) {
        await _createWidgetsFiles(w);
      }

      print(success("\nComponents Added. Check the lib/majestic folder.\n"));

      // Handle dependencies
      handleDependencies(widgets);
    } catch (e) {
      print(error("\n An error occurred: ${e.toString()} \n"));
    }
  }

  void handleDependencies(List<Widget> widgets) async {
    Set<String> allDependencies =
        widgets.expand((widget) => widget.dependencies).toSet();

    if (allDependencies.isEmpty) {
      return;
    }

    final userResponse = MultiSelect(
      prompt:
          'Would you like to opt-out of any of the following dependencies being added to your project?',
      options: allDependencies.toList(),
      defaults: allDependencies.map((e) => true).toList(),
    ).interact();

    List<String> selectedDependencies = [];

    for (int index in userResponse) {
      selectedDependencies.add(allDependencies.elementAt(index));
    }

    if (selectedDependencies.isEmpty) {
      print("No depdnecnies were installed");
      return;
    }

    // Construct the flutter pub add command
    final command = 'flutter';
    final arguments = ['pub', 'add', ...selectedDependencies];

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
  }

  Future<List<Widget>> _fetchWidgets(List<String> requestedComponents) async {
    String query = "q=${requestedComponents.join(',')}";
    final response = await http.get(Uri.parse("$_baseUrl?$query"));

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch widgets');
    }

    final List<dynamic> jsonData = jsonDecode(response.body);
    return jsonData.map((json) => Widget.fromJson(json)).toList();
  }

  Future<void> _createWidgetsFiles(Widget widget) async {
    for (final file in widget.files) {
      final directory = Directory(file.filepath);

      // Create directories if they don't exist
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      // Create file
      final filePath = path.join(file.filepath, file.name);
      final widgetFile = File(filePath);
      await widgetFile.writeAsString(file.content);
    }
  }
}
