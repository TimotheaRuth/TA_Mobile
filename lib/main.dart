import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'login.dart';

void main() {
  await GetStorage.init();
  await GetStorage.init('session');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final session = GetStorage('session');
  late bool isLogin = session.read('isLogin')??false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kamar Inn',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      debugShowCheckedModeBanner: false,
      home: isLogin? HomePage() : LoginScreen(),
    );
  }
}

