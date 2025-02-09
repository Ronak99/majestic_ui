import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:majestic_ui/commands.dart';
import 'package:majestic_ui/data/cli_content.dart';

void main(List<String> arguments) async {
  if (arguments.contains('--help') ||
      arguments.contains('-h') ||
      arguments.isEmpty ||
      arguments.contains('help')) {
    CliContent().printHelpText();
    return;
  }

  final runner = CommandRunner('magestic_cli',
      'A CLI tool for adding beautiful, tested and reliable widgets to your Flutter project.')
    ..addCommand(AddCommand())
    ..addCommand(DocsCommand());
  // ..addCommand(TestCommand());

  runner.run(arguments).catchError((error) {
    if (error is! UsageException) throw error;
    CliContent().errorText(error.message);
    exit(64);
  });
}
