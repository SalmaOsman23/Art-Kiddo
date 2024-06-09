import 'package:artkiddo/core/models/DrawerModel.dart';
import 'package:artkiddo/core/screens/draw_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (context) => DrawerModel(),
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Art Kiddo',
      home: DrawScreen(),
    );
  }
}

