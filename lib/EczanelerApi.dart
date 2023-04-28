// To parse this JSON data, do
//
//     final eczaneler = eczanelerFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Eczaneler {
  Eczaneler({
    required this.success,
    required this.result,
  });

  bool success;
  List<ResultClass> result;

  factory Eczaneler.fromRawJson(String str) =>
      Eczaneler.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Eczaneler.fromJson(Map<String, dynamic> json) => Eczaneler(
        success: json["success"],
        result: List<ResultClass>.from(
            json["result"].map((x) => ResultClass.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class ResultClass {
  ResultClass({
    required this.name,
    required this.dist,
    required this.address,
    required this.phone,
    required this.loc,
  });

  String name;
  String dist;
  String address;
  String phone;
  String loc;

  factory ResultClass.fromRawJson(String str) =>
      ResultClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResultClass.fromJson(Map<String, dynamic> json) => ResultClass(
        name: json["name"],
        dist: json["dist"],
        address: json["address"],
        phone: json["phone"],
        loc: json["loc"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "dist": dist,
        "address": address,
        "phone": phone,
        "loc": loc,
      };
}
