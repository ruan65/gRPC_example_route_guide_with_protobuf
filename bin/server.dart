import 'dart:convert';
import 'dart:io';

import 'package:route_guide_google_example/src/common.dart';
import 'package:route_guide_google_example/src/server.dart';

main(List<String> args) async {

  await Server().main(args);
}
