import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musica_download/pages/home_page.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Color(0xFF5E35B1)),
      home: HomePage(),
    ),
  );
}
