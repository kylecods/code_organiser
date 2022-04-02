import 'dart:io';

import 'package:args/command_runner.dart';

import '../../logger.dart';

class GenerateCommand extends Command {
  final Logger _logger;
  GenerateCommand({
    Logger? logger,
  }) : _logger = logger ?? Logger() {
    argParser.addFlag(
      "verbose",
      help: "Give detailed information of generate process",
      negatable: false,
    );
  }
  @override
  String get description => "Generate a starter project template";

  @override
  String get name => "generate";

  @override
  String get invocation => "org generate [arguments] <directory>";

  String get _statedPath => argResults!.rest.first;

  @override
  Future<int> run() async {
    final verbose = argResults!['verbose'] as bool;

    if (argResults!.rest.length > 1) {
      throw UsageException('Too many arguments', usage);
    }

    if (argResults!.rest.isEmpty) {
      throw UsageException('No directory name is specified', usage);
    }
    final directory = Directory(_statedPath);

    var isThereDir = await directory.exists();

    if (verbose) {
      _logger.logInfo('Created the folder: ${directory.path}');
    }

    if (!isThereDir) {
      await directory.create();
      String createdDirectoryPath = directory.path;

      final subfolders = ['app', 'lib', 'src'];

      for (final subfolder in subfolders) {
        var appFolder = await Directory('$createdDirectoryPath/$subfolder')
            .create(recursive: true);

        if (verbose) {
          _logger.logInfo('Created the subfolder: ${appFolder.path}');
        }
      }
      return exitCode;
    } else {
      throw UsageException("The directory already exists", usage);
    }
  }
}
