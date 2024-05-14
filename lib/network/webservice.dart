import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../utlils/app_constants.dart';
import '../utlils/common.dart';
import '../utlils/utility.dart';

class Resource<T> {
  final String? url;
  T Function(Response response)? parse;

  Resource({this.url, this.parse});
}

class Webservice {
  var tag = "Webservice----";

  Future<T> loadPostMethod<T>(Resource<T> resource, Object body) async {
    Map<String, String> headers = {"Content-Type": "application/json"};
    final response =
        await http.post(Uri.parse(resource.url!), headers: headers, body: body);
    if (kDebugMode) {
      print("response.........................$response");
      print("response.........................${response.statusCode}");
    }
    if (response.statusCode == 200) {
      return resource.parse!(response);
    } else if (response.statusCode == 422) {
      return resource.parse!(response);
    } else if (response.statusCode == 401) {
      return resource.parse!(response);
    } else if (response.statusCode == 405) {
      return resource.parse!(response);
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<T> loadGetDataWithOutHeader<T>(
      Resource<T> resource, String endPoint) async {
    Map<String, String> headers = {
      'X-Api-Key': 'tGxEJbIMVRA6AO6CRot+Rw==IbBXPWhetAjWefu2',
    };

    final response = await http.get(Uri.parse(resource.url! + "${endPoint}"),
        headers: headers);
    if (kDebugMode) {
      printf("response.........................$response");
      printf("response.........................${response.statusCode}");
      printf("response.........................${resource.url}");
    }
    if (response.statusCode == 200) {
      return resource.parse!(response);
    } else if (response.statusCode == 401) {
      Fluttertoast.showToast(msg: "Please enter valid city name");
      return resource.parse!(response);
    } else if (response.statusCode == 500) {
      Fluttertoast.showToast(msg: "Please enter valid city name");
      return resource.parse!(response);
    } else if (response.statusCode == 403) {
      Fluttertoast.showToast(msg: "Please enter valid city name");
      return resource.parse!(response);
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(msg: "Please enter valid city name");
      return resource.parse!(response);
    } else {
      Fluttertoast.showToast(msg: "Please enter valid city name");
      return resource.parse!(response);
      //throw Exception('Failed to load data!');
    }
  }
}
