import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../models/placement.dart';
import '../models/topics.dart';

// Future<List<Topic>> fetchTopics() async {
//   try {
//     String jsonString = await rootBundle.loadString('assets/dummy_data.json');
//     if (jsonString != null && jsonString.isNotEmpty) {
//       List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;
//       print(jsonList.toString());
//       // print("this is the data:");
//       return jsonList.map((data) => Topic.fromMap(data)).toList();
//     } else {
//       print('Empty or null JSON string');
//       return []; // Return an empty list if JSON string is empty or null
//     }
//   } catch (e) {
//     print('Error fetching data: $e');
//     return []; // Return an empty list to indicate failure
//   }
// }
Future<List<Topic>> fetchTopics() async {
  try {
    final String apiUrl = 'https://tech-titans-iota.vercel.app/questions';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      dynamic resultData = jsonData['result'];

      if (resultData is Map<String, dynamic>) {
        List<dynamic> quizzesData = resultData['quizzes'];
        List<Topic> topics = [
          Topic.fromMap({
            '_id': resultData['_id'],
            'title': resultData['title'],
            'description': resultData['description'],
            'img': resultData['img'],
            'quizzes': quizzesData,
          })
        ];
        return topics;
      } else {
        throw Exception('Failed to fetch topics: Invalid data format');
      }
    } else {
      throw Exception('Failed to fetch topics');
    }
  } catch (e) {
    print('Error fetching data: $e');
    return []; // Return an empty list to indicate failure
  }
}



Future<List<Placement>> fetchPlacements() async {
  try {
    final String apiUrl = 'https://tech-titans-iota.vercel.app/placements';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      print("Hooray, the status code is 200");
      print(response.body);
      // If the server returns a 200 OK response, parse the JSON response
      // and return the data.
      List<dynamic> jsonList = jsonDecode(response.body)['placements'];
      return jsonList.map((data) => Placement.fromJson(data)).toList();
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to fetch placements');
    }
  } catch (e) {
    print('Error fetching data: $e');
    return []; // Return an empty list to indicate failure
  }
}

Future<List<Placement>> fetchPlacementData() async {
  final url = 'https://tech-titans-iota.vercel.app/placements';

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // If the server returns a successful response, parse the JSON
      final jsonData = jsonDecode(response.body);

      // Extract the list of placements from the JSON data
      final List<dynamic> placementJsonList = jsonData['placements'];

      // Convert the JSON list to a list of Placement objects
      List<Placement> placements = placementJsonList.map((json) => Placement.fromJson(json)).toList();

      return placements;
    } else {
      // If the server returns an error response, throw an exception
      throw Exception('Failed to fetch placement data');
    }
  } catch (e) {
    // If an error occurs during the HTTP request, throw an exception
    throw Exception('Failed to fetch placement data: $e');
  }
}