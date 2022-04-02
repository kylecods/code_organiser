import 'dart:io';

class Logger {
  ///Flag that enables logging to a specified [fileName]
  final bool? logToFile;

  ///This is the name of the log file
  final String? fileName;

  ///Optionally specify the location where the log files will be stored
  final String? filePath;

  Logger._(
    this.fileName,
    this.logToFile,
    this.filePath,
  );

  ///Creates a Logger instance
  ///
  ///Optional params: [logToFile], [fileName], [filePath]
  factory Logger({
    bool logToFile = false,
    String fileName = "",
    String filePath = "",
  }) {
    return Logger._(fileName, logToFile, filePath);
  }

  ///Outputs `INFO` level message
  ///
  ///params : String [text]
  void logInfo(String text) {
    stdout.write('\u001b[34;1m');
    stdout.writeln(_formatText(text, "INFO"));
    stdout.write('\u001b[0m');
  }

  ///Outputs `WARN` level message
  ///
  ///params : String [text]
  void logWarning(String text) {
    stdout.write('\u001b[33m');
    stdout.writeln(_formatText(text, "WARN"));
    stdout.write('\u001b[0m');
  }

  ///Outputs `ERROR` level message
  ///
  ///params : String [text]
  void logError(String text) {
    stdout.write('\u001b[31m');
    stdout.writeln(_formatText(text, "ERROR"));
    stdout.write('\u001b[0m');
  }

  static String _formatText(String text, String level) {
    return "${DateTime.now()} [$level]: $text";
  }
}
