// To parse this JSON data, do
//
//     final update = updateFromJson(jsonString);

import 'dart:convert';

Update updateFromJson(String str) => Update.fromJson(json.decode(str));

String updateToJson(Update data) => json.encode(data.toJson());

class Update {
  Update({
    required this.entity,
    required this.header,
  });

  List<Entity> entity;
  Header header;

  factory Update.fromJson(Map<String, dynamic> json) => Update(
    entity: List<Entity>.from(json["entity"].map((x) => Entity.fromJson(x))),
    header: Header.fromJson(json["header"]),
  );

  Map<String, dynamic> toJson() => {
    "entity": List<dynamic>.from(entity.map((x) => x.toJson())),
    "header": header.toJson(),
  };
}

class Entity {
  Entity({
    required this.id,
    required this.tripUpdate,
  });

  String id;
  TripUpdate tripUpdate;

  factory Entity.fromJson(Map<String, dynamic> json) => Entity(
    id: json["id"],
    tripUpdate: TripUpdate.fromJson(json["trip_update"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "trip_update": tripUpdate.toJson(),
  };
}

class TripUpdate {
  TripUpdate({
    required this.stopTimeUpdate,
    required this.timestamp,
    required this.trip,
  });

  List<StopTimeUpdate> stopTimeUpdate;
  String timestamp;
  Trip trip;

  factory TripUpdate.fromJson(Map<String, dynamic> json) => TripUpdate(
    stopTimeUpdate: List<StopTimeUpdate>.from(json["stop_time_update"].map((x) => StopTimeUpdate.fromJson(x))),
    timestamp: json["timestamp"],
    trip: Trip.fromJson(json["trip"]),
  );

  Map<String, dynamic> toJson() => {
    "stop_time_update": List<dynamic>.from(stopTimeUpdate.map((x) => x.toJson())),
    "timestamp": timestamp,
    "trip": trip.toJson(),
  };
}

class StopTimeUpdate {
  StopTimeUpdate({
    required this.departure,
    required this.stopId,
    required this.stopSequence,
  });

  Departure departure;
  String stopId;
  int stopSequence;

  factory StopTimeUpdate.fromJson(Map<String, dynamic> json) => StopTimeUpdate(
    departure: Departure.fromJson(json["departure"]),
    stopId: json["stop_id"],
    stopSequence: json["stop_sequence"],
  );

  Map<String, dynamic> toJson() => {
    "departure": departure.toJson(),
    "stop_id": stopId,
    "stop_sequence": stopSequence,
  };
}

class Departure {
  Departure({
    required this.time,
  });

  String time;

  factory Departure.fromJson(Map<String, dynamic> json) => Departure(
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "time": time,
  };
}

class Trip {
  Trip({
    required this.routeId,
    required this.tripId,
  });

  String routeId;
  String tripId;

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
    routeId: json["route_id"],
    tripId: json["trip_id"],
  );

  Map<String, dynamic> toJson() => {
    "route_id": routeId,
    "trip_id": tripId,
  };
}

class Header {
  Header({
    required this.gtfsRealtimeVersion,
    required this.timestamp,
  });

  String gtfsRealtimeVersion;
  String timestamp;

  factory Header.fromJson(Map<String, dynamic> json) => Header(
    gtfsRealtimeVersion: json["gtfs_realtime_version"],
    timestamp: json["timestamp"],
  );

  Map<String, dynamic> toJson() => {
    "gtfs_realtime_version": gtfsRealtimeVersion,
    "timestamp": timestamp,
  };
}
