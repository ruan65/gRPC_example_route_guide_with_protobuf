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
    channel = ClientChannel('127.0.0.1',
        port: 8065,
        options: const ChannelOptions(
          credentials: const ChannelCredentials.insecure(),
        ));

    stub = RouteGuideClient(channel,
    options: CallOptions(timeout: Duration(seconds: 30)));

    try {
      await runGetFeature();
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
        'Found $name at ${latitude / coordFactor}, ${longitude / coordFactor}');
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
}
