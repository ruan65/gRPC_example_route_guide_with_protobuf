import 'dart:async';
import 'dart:math' show atan2, cos, max, min, pi, sin, sqrt;

import 'package:grpc/grpc.dart' as grpc;
import 'package:route_guide_google_example/src/common.dart';

//import 'common.dart';
import 'generated/route_guide.pb.dart';
import 'generated/route_guide.pbgrpc.dart';

class RouteGuideService extends RouteGuideServiceBase {


  @override
  Future<Feature> getFeature(grpc.ServiceCall call, Point request) async {

    print('Got point request: ${request.toString()}');

    return featuresDb.firstWhere((f) => f.location == request,
        orElse: () => new Feature()..location = request);
  }

}

class Server {
  Future<void> main(List<String> args) async {
    final server = grpc.Server([RouteGuideService()]);
    await server.serve(port: 8065);
    print('Server listening on port ${server.port}...');
  }
}