import 'dart:convert';
import 'package:flutter/services.dart';

import '../models/topics.dart';

Future<List<Topic>> fetchTopics() async {
  try {
    String jsonString = await rootBundle.loadString('assets/dummy_data.json');
    if (jsonString != null && jsonString.isNotEmpty) {
      List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;
      print(jsonList.toString());
      print("this is the data:");
      return jsonList.map((data) => Topic.fromMap(data)).toList();
    } else {
      print('Empty or null JSON string');
      return []; // Return an empty list if JSON string is empty or null
    }
  } catch (e) {
    print('Error fetching data: $e');
    return []; // Return an empty list to indicate failure
  }
}

