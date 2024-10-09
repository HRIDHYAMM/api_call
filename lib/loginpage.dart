

import 'package:ere_task/blankpage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart'; // For navigation and Snackbar
import 'package:shared_preferences/shared_preferences.dart'; // For local storage

class LoginScreen extends StatelessWidget {
  final String apiUrl = "https://musicapp.jissanto.com/api/login";
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});
Future<void> makeApiCall(BuildContext context) async {
  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode({
        'username': emailController.text,
        'password': passwordController.text,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final token = responseBody['token'];

      await saveToken(token);

      Get.offAll(() => BlankPage()); // Navigate to BlankPage and clear back stack
    } else {
      final errorResponse = json.decode(response.body);
      final errorMessage = errorResponse['message'] ?? 'Failed to login'; // Adjust based on your API response structure
      showSnackbar('Error', errorMessage);
    }
  } catch (e) {
    showSnackbar('Error', 'An error occurred: $e');
  }
}


  void showSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token);
  }

  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
          backgroundColor: Colors.black,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              
              children: [
                
                Container(
                
                  decoration: BoxDecoration(
                    color: Colors.black
                  ),
                  child: Column(
                    
                    children: [
                       SizedBox(
                        width: double.maxFinite,
                         child: Image.asset(
                          "assets/logo.png",
                          
                          ),
                       ),
            
            
                 Text("Login",style: TextStyle(color: Colors.white,fontSize: 18),),
            SizedBox(
              height: 30,
            ),
                 SizedBox(
                  height: 50,
                   child: TextField(
                    style: TextStyle(color: Colors.white),
                    controller: emailController,
                    keyboardType:TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "johndoepiano@gmal.com",
                      fillColor: Colors.grey[900],
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.grey
                        )
                      ),
                      border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(20),
                   
                      )
                    ),
                   ),
                 ),
                  SizedBox(
              height: 20,
            ),
                 SizedBox(
          height: 50,
          child: TextField(
        controller: passwordController,
        keyboardType: TextInputType.number,
        style: TextStyle(color: Colors.white),
        obscureText: true, // This makes the input obscured
           
        decoration: InputDecoration(
          hintText: "● ● ● ● ● ● ●", // Set the hint text to "8 numbers"
          fillColor: Colors.grey[900],
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
          ),
        ),
        
                  SizedBox(
              height: 30,
            ),
        
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                
               style: ButtonStyle(
                backgroundColor:WidgetStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
         
        )
          )
        ),
                 onPressed: () => makeApiCall(context)
                
                , child: Text("Login")),
            ),
                         
               SizedBox(
              height: 100,
            ),
        
            Padding(
              padding: const EdgeInsets.only(left: 70),
              child: Row(
                children: [
                  Text("Don't have an account?",style: TextStyle(
                    color: Colors.white,
                    fontSize: 14
                  ),),
                  TextButton(onPressed: (){}, child: Text("Create One",style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),))
                ],
              ),
            ),
            SizedBox(
              height: 130,
            ),
         Padding(
           padding: const EdgeInsets.only(left: 40),
           child: Row(
             children: [
               Flexible(
            child: Text(
              "By continuing, you are agreeing to our",
              style: TextStyle(color: Colors.white,
              fontSize: 10
              ),
              overflow: TextOverflow.ellipsis, // Optional: handle overflow
              
            ),
            
               ),
               SizedBox(
                width: 5,
               ),
               Text(
             "Terms and Conditions",
            style: TextStyle(
               decoration: TextDecoration.underline,
               decorationColor: Colors.white,
               fontSize: 12,
              color: Colors.white,
            fontWeight: FontWeight.bold,
           
            ),
               ),
             ],
           ),
         )
        
            
                    ],
                  ),
                )
                ,
               
              ],
            ),
          ),
        );
   
  }
}

