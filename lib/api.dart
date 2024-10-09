import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart'; // for jsonEncode

class ApiTaskPage extends StatefulWidget {
  @override
  _ApiTaskPageState createState() => _ApiTaskPageState();
}

class _ApiTaskPageState extends State<ApiTaskPage> {
  final String apiUrl = 'https://musicapp.jissanto.com/api/baseurl/login';
  final String username = 'Try';
  final String password = '123456';

  Future<void> makeApiCall() async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Success - navigate to a blank page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BlankPage()),
        );

        // Extract token and save to local storage
        final token = jsonDecode(response.body)['token'];
        saveToken(token);
      } else {
        // Error - show a Snackbar with error message
        showErrorSnackbar('Login failed. Please try again.');
      }
    } catch (error) {
      // Error - show a Snackbar with error message
      showErrorSnackbar('Network error. Please try again.');
    }
  }

  void showErrorSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('API Task')),
      body: Center(
        child: ElevatedButton(
          onPressed: makeApiCall,
          child: Text('Make API Call'),
        ),
      ),
    );
  }
}

class BlankPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Success! This is a blank page.')),
    );
  }
}
