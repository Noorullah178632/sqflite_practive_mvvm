import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_practice_mvvm/view/home_view.dart';
import 'package:sqlite_practice_mvvm/view_models/sqflite_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => SqfliteViewModel())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: HomeView(),
    );
  }
}
