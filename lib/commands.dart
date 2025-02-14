import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:majestic_ui/data/cli_content.dart';
import 'package:majestic_ui/magestic_cli.dart';

class AddCommand extends Command {
  @override
  final name = 'add';

  @override
  final description = 'Add components to your Flutter project.';

  AddCommand();

  @override
  Future<void> run() async {
    if (argResults!.rest.isEmpty) {
      CliContent().noParameters();
      return;
    }

    final requestedWidgets = argResults!.rest;
    final cli = MagesticCli();
    await cli.add(requestedWidgets);
  }
}

class TestCommand extends Command {
  @override
  final name = 'test';

  @override
  final description = 'Mainly for testing purposes.';

  TestCommand();

  @override
  Future<void> run() async {
    final cli = MagesticCli();
    // await cli.test();
  }
}

class DocsCommand extends Command {
  @override
  final name = 'docs';

  @override
  final description = 'Launch docs.';

  DocsCommand();

  @override
  Future<void> run() async {
    final url = 'https://majesticui.com/installation';

    try {
      if (Platform.isWindows) {
        await Process.run('cmd', ['/c', 'start', url]);
      } else if (Platform.isMacOS) {
        await Process.run('open', [url]);
      } else if (Platform.isLinux) {
        await Process.run('xdg-open', [url]);
      } else {
        print('Unsupported platform. Please visit: $url');
      }
    } catch (e) {
      print('Error launching browser: $e');
      print('Please visit: $url');
    }
  }
}
