///
//  Generated code. Do not modify.
//  source: route_guide.proto
///
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name

const Point$json = const {
  '1': 'Point',
  '2': const [
    const {'1': 'latitude', '3': 1, '4': 1, '5': 5, '10': 'latitude'},
    const {'1': 'longitude', '3': 2, '4': 1, '5': 5, '10': 'longitude'},
  ],
};

const Feature$json = const {
  '1': 'Feature',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'location', '3': 2, '4': 1, '5': 11, '6': '.routeguide.Point', '10': 'location'},
  ],
};

const Rectangle$json = const {
  '1': 'Rectangle',
  '2': const [
    const {'1': 'lo', '3': 1, '4': 1, '5': 11, '6': '.routeguide.Point', '10': 'lo'},
    const {'1': 'hi', '3': 2, '4': 1, '5': 11, '6': '.routeguide.Point', '10': 'hi'},
  ],
};

