// ignore_for_file: prefer_final_fields, unused_field, avoid_print
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class Data with ChangeNotifier {
  List<dynamic> _list = [];
  bool _error = false;
  String _errorMessage = '';

  List<dynamic> get list => _list;
  bool get error => _error;
  String get errorMessage => _errorMessage;

  Future<void> get fetchData async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      try {
        // print(response.body);
        _list = jsonDecode(response.body);
        // print(_map);
        _error = false;
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _list = [];
      }
    } else {
      _list = [];
      _error = true;
      _errorMessage = 'It could be your network problem';
    }
    notifyListeners();
  }
}
