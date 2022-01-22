import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:get/get.dart';
//import 'package:get_storage/get_storage.dart';
import 'package:popquiz/menu.dart';

void main() async {
//  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFFDE982A),
      ),
    );
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CheckMob',
      initialRoute: '/',
      home: Menu(),
    );
  }
}
