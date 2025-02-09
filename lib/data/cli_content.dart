import 'package:chalkdart/chalkdart.dart';

class CliContent {
  Chalk error = chalk.bold.red;
  Chalk warning = chalk.keyword('orange');
  Chalk success = chalk.greenBright;

  CliContent() {
    // Set theme color
    Chalk.addColorKeywordHex('rose', '#ffccd3');
    Chalk.addColorKeywordHex('pink', '#ffa1ae');
    Chalk.addColorKeywordHex('purple', '#dab2ff');
    Chalk.addColorKeywordHex('purpleBright', '#c17bff');
    Chalk.addColorKeywordHex('tealBright', '#46edd4');
    Chalk.addColorKeywordHex('indigo', '#8fc5ff');
    Chalk.addColorKeywordHex('orange', '#ffb86a');
    Chalk.addColorKeywordHex('orangeBright', '#ff8906');

    Chalk.addColorKeywordHex('theme', '#8fc5ff');
  }

  void printColors() {
    print(chalk.color.rose("rose"));
    print(chalk.color.pink("pink"));
    print(chalk.color.purple("purple"));
    print(chalk.color.purpleBright("purpleBright"));
    print(chalk.color.tealBright("tealBright"));
    print(chalk.color.indigo("indigo"));
  }

  void printHelpText() {
    final String name = "Welcome to MajesticUI (1.0.4)";
    final String description =
        "A CLI tool for adding beautiful, tested and reliable widgets to your Flutter project.";
    final String usage = "";

    // Printing part
    print("\n");
    print(chalk.greenBright.bold("Welcome to MajesticUI (1.0.4)"));
    print(chalk.greenBright(description));

    // Description
    print("\n");
    print(chalk.yellow("Usage: magestic_ui <command> [arguments]"));

    print("\n");
    print(chalk.yellow.bold("Available Commands:\n"));
    print(chalk
        .yellow("add   Add one or more components to your Flutter project."));
    print(chalk.yellow("help  Help Command."));
    print(chalk.yellow("docs  Launch documentation at majesticui.com"));

    print("\n");
  }

  void noParameters() {
    final String name = "Welcome to MajesticUI (1.0.4)";
    final String description =
        "A CLI tool for adding beautiful, tested and reliable widgets to your Flutter project.";
    final String usage = "";

    // Printing part
    print("\n");
    print(
      chalk.brightRed("It seems you forgot to provide a component name."),
    );

    // Suggestion
    print("\n");
    print(
      chalk.yellow("Try writing:"),
    );
    print(chalk.brightGreen("majestic_ui add star_rush_background"));

    print("\n");
    // Docs
    print(
      chalk.yellow(
          "Check out the documentation by running the command: majestic_ui docs"),
    );

    print("\n");
  }

  void errorText(String errorText) {
    // // Printing part
    print("\n");
    print(chalk.brightRed(errorText));

    // Docs
    print(
      chalk.yellow(
          "Check out the documentation by running the command: majestic_ui docs"),
    );
    print("\n");
  }
}
