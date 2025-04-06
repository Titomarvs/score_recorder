import 'package:flutter/material.dart';
import '../controllers/quiz_controller.dart';
import 'FailScreen.dart';
import 'PassScreen.dart';

class AddQuizScreen extends StatefulWidget {
  final Function() onQuizAdded;

  const AddQuizScreen({super.key, required this.onQuizAdded});

  @override
  _AddQuizScreenState createState() => _AddQuizScreenState();
}

class _AddQuizScreenState extends State<AddQuizScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController scoreController = TextEditingController();
  final TextEditingController overallScoreController = TextEditingController();
  final QuizController _quizController = QuizController();

  void _saveQuiz() async {
    String quizName = nameController.text;
    int score = int.tryParse(scoreController.text) ?? 0;
    int overallScore = int.tryParse(overallScoreController.text) ?? 1;

    if (quizName.isEmpty || overallScore == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields correctly'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    await _quizController.addQuiz(quizName, score, overallScore);
    widget.onQuizAdded();
    double percentage = (score / overallScore) * 100;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => percentage < 50
            ? FailScreen(score: score, overallScore: overallScore)
            : PassScreen(score: score, overallScore: overallScore),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 66, 2, 2),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[900],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          labelStyle: const TextStyle(color: Colors.white70),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 77, 231, 255),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Quiz Score Recorder',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 166, 243, 41),
                  Color.fromARGB(255, 74, 234, 95),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Quiz/Activity Name'),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: scoreController,
                decoration: const InputDecoration(labelText: 'Your Score'),
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: overallScoreController,
                decoration: const InputDecoration(labelText: 'Overall Score'),
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveQuiz,
                  child: const Text(
                    'Save Quiz',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
