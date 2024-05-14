import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

printf(String msg) {
  if (kDebugMode) {
    print(msg);
  }
}

commonSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}