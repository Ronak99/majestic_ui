// bin/magestic_cli.dart
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:majestic_ui/magestic_cli.dart';

class AddCommand extends Command {
  @override
  final name = 'add';

  @override
  final description =
      'Add beautiful, tested and reliable widgets to your Flutter project.';

  AddCommand();

  @override
  Future<void> run() async {
    if (argResults!.rest.isEmpty) {
      print('Please specify a widget name');
      return;
    }

    final widgetName = argResults!.rest.first;
    final cli = MagesticCli();
    await cli.add(widgetName);
  }
}

void main(List<String> arguments) {
  final runner = CommandRunner('magestic_cli',
      'A CLI tool for adding beautiful, tested and reliable widgets to your Flutter project.')
    ..addCommand(AddCommand());

  runner.run(arguments).catchError((error) {
    if (error is! UsageException) throw error;
    print(error);
    exit(64);
  });
}
