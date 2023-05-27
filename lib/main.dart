import 'package:flutter/material.dart';
import 'package:infinite_pagination/pages/home.dart';
import 'package:infinite_pagination/providers/user_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Infinite Pagination',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider(
          create: (_) => UserProvider(),
          child: const MyHomePage(title: 'Infinite Pagination')),
    );
  }
}
