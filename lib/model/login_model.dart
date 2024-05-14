// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

class LoginModel {
  LoginModel({
    this.success,
    this.message,
    this.statusCode,
  });

  bool? success;
  String? message;
  int? statusCode;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    success: json["success"],
    message:  json["message"],
    // data: Data.fromJson(json["data"]),
  );
}


