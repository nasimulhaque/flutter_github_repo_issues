// To parse this JSON data, do
//
//     final issueResponseModel = issueResponseModelFromJson(jsonString);

import 'dart:convert';

List<Issue> issueResponseModelFromJson(List<dynamic> list) => List<Issue>.from(list.map((x) => Issue.fromJson(x)));

String issueResponseModelToJson(List<Issue> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Issue {
  int id;
  String title;
  User user;
  List<Label> labels;
  DateTime createdAt;
  String? body;

  Issue({
    required this.id,
    required this.title,
    required this.user,
    required this.labels,
    required this.createdAt,
    required this.body,
  });

  factory Issue.fromJson(Map<String, dynamic> json) => Issue(
    id: json["id"],
    title: json["title"],
    user: User.fromJson(json["user"]),
    labels: List<Label>.from(json["labels"].map((x) => Label.fromJson(x))),
    createdAt: DateTime.parse(json["created_at"]),
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "user": user.toJson(),
    "labels": List<dynamic>.from(labels.map((x) => x.toJson())),
    "created_at": createdAt.toIso8601String(),
    "body": body,
  };
}

class Label {
  int id;
  String name;
  String color;
  bool labelDefault;

  Label({
    required this.id,
    required this.name,
    required this.color,
    required this.labelDefault,
  });

  factory Label.fromJson(Map<String, dynamic> json) => Label(
    id: json["id"],
    name: json["name"],
    color: json["color"],
    labelDefault: json["default"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "color": color,
    "default": labelDefault,
  };
}

class User {
  String login;
  int id;

  User({
    required this.login,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    login: json["login"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "login": login,
    "id": id,
  };
}
