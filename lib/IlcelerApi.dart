// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
    String status;
    Data data;

    Welcome({
        required this.status,
        required this.data,
    });

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        status: json["status"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
    };
}

class Data {
    int id;
    String name;
    int area;
    int population;
    int altitude;
    List<int> areaCode;
    bool isMetropolitan;
    Coordinates coordinates;
    Maps maps;
    Region region;
    List<District> districts;

    Data({
        required this.id,
        required this.name,
        required this.area,
        required this.population,
        required this.altitude,
        required this.areaCode,
        required this.isMetropolitan,
        required this.coordinates,
        required this.maps,
        required this.region,
        required this.districts,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        area: json["area"],
        population: json["population"],
        altitude: json["altitude"],
        areaCode: List<int>.from(json["areaCode"].map((x) => x)),
        isMetropolitan: json["isMetropolitan"],
        coordinates: Coordinates.fromJson(json["coordinates"]),
        maps: Maps.fromJson(json["maps"]),
        region: Region.fromJson(json["region"]),
        districts: List<District>.from(json["districts"].map((x) => District.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "area": area,
        "population": population,
        "altitude": altitude,
        "areaCode": List<dynamic>.from(areaCode.map((x) => x)),
        "isMetropolitan": isMetropolitan,
        "coordinates": coordinates.toJson(),
        "maps": maps.toJson(),
        "region": region.toJson(),
        "districts": List<dynamic>.from(districts.map((x) => x.toJson())),
    };
}

class Coordinates {
    double latitude;
    double longitude;

    Coordinates({
        required this.latitude,
        required this.longitude,
    });

    factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
    };
}

class District {
    int id;
    String name;
    int area;
    int population;

    District({
        required this.id,
        required this.name,
        required this.area,
        required this.population,
    });

    factory District.fromJson(Map<String, dynamic> json) => District(
        id: json["id"],
        name: json["name"],
        area: json["area"],
        population: json["population"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "area": area,
        "population": population,
    };
}

class Maps {
    String googleMaps;
    String openStreetMap;

    Maps({
        required this.googleMaps,
        required this.openStreetMap,
    });

    factory Maps.fromJson(Map<String, dynamic> json) => Maps(
        googleMaps: json["googleMaps"],
        openStreetMap: json["openStreetMap"],
    );

    Map<String, dynamic> toJson() => {
        "googleMaps": googleMaps,
        "openStreetMap": openStreetMap,
    };
}

class Region {
    String en;
    String tr;

    Region({
        required this.en,
        required this.tr,
    });

    factory Region.fromJson(Map<String, dynamic> json) => Region(
        en: json["en"],
        tr: json["tr"],
    );

    Map<String, dynamic> toJson() => {
        "en": en,
        "tr": tr,
    };
}
