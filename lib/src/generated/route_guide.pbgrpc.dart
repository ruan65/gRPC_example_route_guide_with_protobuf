///
//  Generated code. Do not modify.
//  source: route_guide.proto
///
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'package:grpc/service_api.dart' as $grpc;

import 'dart:core' as $core show int, String, List;

import 'route_guide.pb.dart';
export 'route_guide.pb.dart';

class RouteGuideClient extends $grpc.Client {
  static final _$getFeature = $grpc.ClientMethod<Point, Feature>(
      '/routeguide.RouteGuide/GetFeature',
      (Point value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => Feature.fromBuffer(value));
  static final _$listFeatures = $grpc.ClientMethod<Rectangle, Feature>(
      '/routeguide.RouteGuide/ListFeatures',
      (Rectangle value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => Feature.fromBuffer(value));
  static final _$recordRoute = $grpc.ClientMethod<Point, RouteSummary>(
      '/routeguide.RouteGuide/RecordRoute',
      (Point value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => RouteSummary.fromBuffer(value));
  static final _$routeChat = $grpc.ClientMethod<RouteNote, RouteNote>(
      '/routeguide.RouteGuide/RouteChat',
      (RouteNote value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => RouteNote.fromBuffer(value));

  RouteGuideClient($grpc.ClientChannel channel, {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<Feature> getFeature(Point request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getFeature, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseStream<Feature> listFeatures(Rectangle request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$listFeatures, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseStream(call);
  }

  $grpc.ResponseFuture<RouteSummary> recordRoute($async.Stream<Point> request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$recordRoute, request, options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseStream<RouteNote> routeChat($async.Stream<RouteNote> request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$routeChat, request, options: options);
    return $grpc.ResponseStream(call);
  }
}

abstract class RouteGuideServiceBase extends $grpc.Service {
  $core.String get $name => 'routeguide.RouteGuide';

  RouteGuideServiceBase() {
    $addMethod($grpc.ServiceMethod<Point, Feature>(
        'GetFeature',
        getFeature_Pre,
        false,
        false,
        ($core.List<$core.int> value) => Point.fromBuffer(value),
        (Feature value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<Rectangle, Feature>(
        'ListFeatures',
        listFeatures_Pre,
        false,
        true,
        ($core.List<$core.int> value) => Rectangle.fromBuffer(value),
        (Feature value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<Point, RouteSummary>(
        'RecordRoute',
        recordRoute,
        true,
        false,
        ($core.List<$core.int> value) => Point.fromBuffer(value),
        (RouteSummary value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<RouteNote, RouteNote>(
        'RouteChat',
        routeChat,
        true,
        true,
        ($core.List<$core.int> value) => RouteNote.fromBuffer(value),
        (RouteNote value) => value.writeToBuffer()));
  }

  $async.Future<Feature> getFeature_Pre(
      $grpc.ServiceCall call, $async.Future request) async {
    return getFeature(call, await request);
  }

  $async.Stream<Feature> listFeatures_Pre(
      $grpc.ServiceCall call, $async.Future request) async* {
    yield* listFeatures(call, (await request) as Rectangle);
  }

  $async.Future<Feature> getFeature($grpc.ServiceCall call, Point request);
  $async.Stream<Feature> listFeatures(
      $grpc.ServiceCall call, Rectangle request);
  $async.Future<RouteSummary> recordRoute(
      $grpc.ServiceCall call, $async.Stream<Point> request);
  $async.Stream<RouteNote> routeChat(
      $grpc.ServiceCall call, $async.Stream<RouteNote> request);
}
