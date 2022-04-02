import 'package:organiser/logger.dart';
import 'package:organiser/organiser.dart';

final logger = Logger();

void main(List<String> arguments) async {
  await OrganiserCommandRunner().run(arguments);
}
