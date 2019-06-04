import 'dart:async';
import 'dart:math' show atan2, cos, max, min, pi, sin, sqrt;

import 'package:grpc/grpc.dart' as grpc;
import 'package:route_guide_google_example/src/common.dart';

//import 'common.dart';
import 'generated/route_guide.pb.dart';
import 'generated/route_guide.pbgrpc.dart';

class RouteGuideService extends RouteGuideServiceBase {

  //
  final routeNotes = <Point, List<RouteNote>>{};

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
      if (_contains(normalizedRectangle, location)) {
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

  @override
  Future<RouteSummary> recordRoute(
      grpc.ServiceCall call, Stream<Point> request) async {

    print("Record route called");

    int pointCount = 0;
    int featureCount = 0;
    double distance = 0.0;
    Point previous;
    final timer = Stopwatch();

    await for (var location in request) {
      if (!timer.isRunning) {
        timer.start();
      }
      pointCount++;
      final feature = featuresDb.firstWhere((f) => f.location == location,
          orElse: () => null);

      print('got feature by location request: ${feature.name}');

      if (feature != null) {
        featureCount++;
      }

      if (previous != null) {
        distance += _distance(previous, location);
      }
      previous = location;
    }
    timer.stop();

    return RouteSummary()
      ..pointCount = pointCount
      ..featureCount = featureCount
      ..distance = distance.round()
      ..elapsedTime = timer.elapsed.inSeconds;
  }

  @override
  Stream<RouteNote> routeChat(grpc.ServiceCall call, Stream<RouteNote> request) async* {

    await for (var note in request) {
      final notes = routeNotes.putIfAbsent(note.location, () => <RouteNote>[]);
      for (var note in notes) {
        yield note;
      }
      notes.add(note);
    }
  }
}

/// Calculate the distance between two points using the "haversine" formula.
/// This code was taken from http://www.movable-type.co.uk/scripts/latlong.html.
double _distance(Point start, Point end) {
  double toRadians(double num) {
    return num * pi / 180;
  }

  final lat1 = start.latitude / coordFactor;
  final lat2 = end.latitude / coordFactor;
  final lon1 = start.longitude / coordFactor;
  final lon2 = end.longitude / coordFactor;
  final R = 6371000; // metres
  final phi1 = toRadians(lat1);
  final phi2 = toRadians(lat2);
  final dLat = toRadians(lat2 - lat1);
  final dLon = toRadians(lon2 - lon1);

  final a = sin(dLat / 2) * sin(dLat / 2) +
      cos(phi1) * cos(phi2) * sin(dLon / 2) * sin(dLon / 2);
  final c = 2 * atan2(sqrt(a), sqrt(1 - a));

  return R * c;
}

class Server {
  Future<void> main(List<String> args) async {
    final server = grpc.Server([RouteGuideService()]);
    await server.serve(port: 8065);
    print('Server listening on port ${server.port}...');
  }
}
