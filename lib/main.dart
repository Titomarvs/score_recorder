import 'package:flutter/material.dart';
import 'views/quiz_view.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Score Recorder',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: QuizView(),
    ),
  );
}
