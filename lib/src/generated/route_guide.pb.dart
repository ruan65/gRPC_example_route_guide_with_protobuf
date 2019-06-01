///
//  Generated code. Do not modify.
//  source: route_guide.proto
///
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name

import 'dart:core' as $core show bool, Deprecated, double, int, List, Map, override, String;

import 'package:protobuf/protobuf.dart' as $pb;

class Point extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Point', package: const $pb.PackageName('routeguide'))
    ..a<$core.int>(1, 'latitude', $pb.PbFieldType.O3)
    ..a<$core.int>(2, 'longitude', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  Point() : super();
  Point.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Point.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Point clone() => Point()..mergeFromMessage(this);
  Point copyWith(void Function(Point) updates) => super.copyWith((message) => updates(message as Point));
  $pb.BuilderInfo get info_ => _i;
  static Point create() => Point();
  Point createEmptyInstance() => create();
  static $pb.PbList<Point> createRepeated() => $pb.PbList<Point>();
  static Point getDefault() => _defaultInstance ??= create()..freeze();
  static Point _defaultInstance;

  $core.int get latitude => $_get(0, 0);
  set latitude($core.int v) { $_setSignedInt32(0, v); }
  $core.bool hasLatitude() => $_has(0);
  void clearLatitude() => clearField(1);

  $core.int get longitude => $_get(1, 0);
  set longitude($core.int v) { $_setSignedInt32(1, v); }
  $core.bool hasLongitude() => $_has(1);
  void clearLongitude() => clearField(2);

  $core.String toString() {
    // TODO: implement toString
    return "Point: lat=$latitude lon=$longitude";
  }
}

class Feature extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Feature', package: const $pb.PackageName('routeguide'))
    ..aOS(1, 'name')
    ..a<Point>(2, 'location', $pb.PbFieldType.OM, Point.getDefault, Point.create)
    ..hasRequiredFields = false
  ;

  Feature() : super();
  Feature.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Feature.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Feature clone() => Feature()..mergeFromMessage(this);
  Feature copyWith(void Function(Feature) updates) => super.copyWith((message) => updates(message as Feature));
  $pb.BuilderInfo get info_ => _i;
  static Feature create() => Feature();
  Feature createEmptyInstance() => create();
  static $pb.PbList<Feature> createRepeated() => $pb.PbList<Feature>();
  static Feature getDefault() => _defaultInstance ??= create()..freeze();
  static Feature _defaultInstance;

  $core.String get name => $_getS(0, '');
  set name($core.String v) { $_setString(0, v); }
  $core.bool hasName() => $_has(0);
  void clearName() => clearField(1);

  Point get location => $_getN(1);
  set location(Point v) { setField(2, v); }
  $core.bool hasLocation() => $_has(1);
  void clearLocation() => clearField(2);
}

