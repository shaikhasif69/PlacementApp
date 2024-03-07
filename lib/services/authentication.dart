import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/users.dart';

class Authentication {
  static Future<UserData?> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse("https://tech-titans-iota.vercel.app/studentLogin"),
      body: jsonEncode({"email": email, "password": password}),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final userDataJson = jsonDecode(response.body)['data'];
      final userData = UserData.fromJson(userDataJson);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userId', userData.id);
      prefs.setString('userEmail', userData.email);
      prefs.setString('userPassword', userData.password);
      prefs.setString("userName", userData.username);
      prefs.setString("userRoll",userData.rollNumber);
      prefs.setString("cgpa",userData.cgpa.toString());
      prefs.setString("isSelected", userData.appliedPlacements[0].status);

      return userData;
    } else {
      throw Exception('Failed to login');
    }
  }
}
