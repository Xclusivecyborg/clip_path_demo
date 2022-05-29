import 'package:clip_path_demo/flash_loader.dart';
import 'package:clip_path_demo/path.dart';
import 'package:clip_path_demo/spin_loader.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SpinLoader(),
    );
  }
}