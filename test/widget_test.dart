import 'package:flutter/material.dart';

class QuizView extends StatelessWidget {
  const QuizView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz View')),
      body: Center(child: Text('Welcome to the Quiz!')),
    );
  }
}
