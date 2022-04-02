import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:organiser/logger.dart';

import 'commands/generate_command.dart';

class OrganiserCommandRunner extends CommandRunner {
  final Logger _logger;
  OrganiserCommandRunner({Logger? logger})
      : _logger = logger ?? Logger(),
        super("org", "Generator to structure your code project") {
    argParser.addFlag(
      "version",
      help: "Display package version",
      negatable: false,
    );
    addCommand(GenerateCommand(logger: logger));
  }

  @override
  Future<int> run(Iterable<String> args) async {
    try {
      final _argResults = parse(args);

      return await runCommand(_argResults) ?? exitCode;
    } on UsageException catch (e) {
      _logger.logError("Usage error: ${e.message}");

      return 42;
    }
  }

  @override
  Future<int?> runCommand(ArgResults topLevelResults) async {
    final version = topLevelResults['version'] as bool?;

    if (version!) {
      print("Code Organiser version 0.0.1");
      return exitCode;
    }
    return await super.runCommand(topLevelResults);
  }
}
