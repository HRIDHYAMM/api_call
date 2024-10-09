// import 'package:ere_task/loginpage.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// void main(){
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: LoginPage(),
//     );
//   }
// }

import 'package:ere_task/api.dart';
import 'package:ere_task/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false    ,
      home: LoginScreen(),
    );
  }
}
