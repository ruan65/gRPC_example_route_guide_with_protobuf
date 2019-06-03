import 'dart:async';
import 'dart:math' show Random;

import 'package:grpc/grpc.dart';

import 'common.dart';
import 'generated/route_guide.pb.dart';
import 'generated/route_guide.pbgrpc.dart';

class Client {
  ClientChannel channel;
  RouteGuideClient stub;

  Future<void> main(List<String> args) async {
    //
    channel = ClientChannel('127.0.0.1',
        port: 8065,
        options: const ChannelOptions(
          credentials: const ChannelCredentials.insecure(),
        ));

    stub = RouteGuideClient(channel,
        options: CallOptions(timeout: Duration(seconds: 30)));

    try {
//      print('Running getFeture on the server');
//      await runGetFeature();
//      print("Running listFeatures server stream");
//      await runListFeatures();

    print('Streaming the route......');

    await runRecordRoute();

    } catch (exception) {
      print('Caught error: $exception');
    }
    await channel.shutdown();
  }

  void printFeature(Feature feature) {
    final latitude = feature.location.latitude;
    final longitude = feature.location.longitude;
    final name = feature.name.isEmpty
        ? 'no feature'
        : 'feature called "${feature.name}"';
    print(
        'Found!!!: $name at ${latitude / coordFactor}, ${longitude / coordFactor}');
  }

  Future<void> runGetFeature() async {
    final point1 = new Point()
      ..latitude = 409146138
      ..longitude = -746188906;
    final point2 = new Point()
      ..latitude = 0
      ..longitude = 0;

    printFeature(await stub.getFeature(point1));
    printFeature(await stub.getFeature(point2));
  }

  Future<void> runListFeatures() async {
    final lo = new Point()
      ..latitude = 400000000
      ..longitude = -750000000;
    final hi = new Point()
      ..latitude = 420000000
      ..longitude = -730000000;
    final rect = new Rectangle()
      ..lo = lo
      ..hi = hi;

    print('Looking for features between 40, -75 and 42, -73');

    await for (var feature in stub.listFeatures(rect)) {
      printFeature(feature);
    }
  }

  Future<void> runRecordRoute() async {
    Stream<Point> generateRoute(int count) async* {
      final rnd = Random();
      for (int i = 0; i < count; i++) {
        final point = featuresDb[rnd.nextInt(featuresDb.length)].location;
        print(
            'Visiting point ${point.longitude / coordFactor}, ${point.longitude / coordFactor}');

        yield point;
        await Future.delayed(Duration(milliseconds: 200 + rnd.nextInt(200)));
      }
    }

    final summary = await stub.recordRoute(generateRoute(10));

    print('Finished trip with ${summary.pointCount} points');
    print('Passed ${summary.featureCount} features');
    print('Travelled ${summary.distance} meters');
    print('It took ${summary.elapsedTime} seconds');
  }
}
