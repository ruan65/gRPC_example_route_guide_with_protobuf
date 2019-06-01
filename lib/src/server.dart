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

  @override
  Stream<Feature> listFeatures(
      grpc.ServiceCall call, Rectangle request) async* {

    print("Server got request for streaming features: $request");

    final normalizedRectangle = _normalize(request);

    for (var feature in featuresDb) {
      if (feature.name.isEmpty) {
        continue;
      }
      final location = feature.location;
      if(_contains(normalizedRectangle, location)) {
        await Future.delayed(Duration(milliseconds: 200));
        print("yielding to the stream: ${feature.name}");
        yield feature;
      }
    }
  }

  Rectangle _normalize(Rectangle r) {
    final lo = new Point()
      ..latitude = min(r.lo.latitude, r.hi.latitude)
      ..longitude = min(r.lo.longitude, r.hi.longitude);

    final hi = new Point()
      ..latitude = max(r.lo.latitude, r.hi.latitude)
      ..longitude = max(r.lo.longitude, r.hi.longitude);

    return new Rectangle()
      ..lo = lo
      ..hi = hi;
  }

  bool _contains(Rectangle r, Point p) =>
      p.longitude >= r.lo.longitude &&
      p.longitude <= r.hi.longitude &&
      p.latitude >= r.lo.latitude &&
      p.latitude <= r.hi.latitude;
}

class Server {
  Future<void> main(List<String> args) async {
    final server = grpc.Server([RouteGuideService()]);
    await server.serve(port: 8065);
    print('Server listening on port ${server.port}...');
  }
}
