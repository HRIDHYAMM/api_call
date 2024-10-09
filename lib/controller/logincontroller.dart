import 'package:ere_task/blankpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  // Function to handle login
  Future<void> logindetails() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Please fill in both email and password.", colorText: Colors.red);
      return;
    }

    try {
      // Making the API call
      final response = await http.post(
        Uri.parse('https://musicapp.jissanto.com/api/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        String token = data['token'];

        // Handle successful login and save token
        await saveToken(token);
        Get.snackbar("Success", "Login Successful");
        Get.off(() => BlankPage()); // Navigate to the blank page
      } else {
        // Handle errors based on status code
        final errorResponse = json.decode(response.body);
        Get.snackbar("Error", errorResponse['message'] ?? "Login failed", colorText: Colors.red);
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: ${e.toString()}", colorText: Colors.red);
    }
  }

  // Function to save the authentication token to local storage
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  @override
  void onInit() {
    super.onInit();
  }
}
