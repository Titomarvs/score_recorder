import 'package:flutter/material.dart';
import '../controllers/quiz_controller.dart';
import '../models/quiz.dart';
import 'addquizscreen.dart';

class QuizView extends StatefulWidget {
  const QuizView({super.key});

  @override
  _QuizViewState createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  final QuizController _controller = QuizController();
  final nameController = TextEditingController();
  final scoreController = TextEditingController();
  final overallScoreController = TextEditingController();
  List<Quiz> quizzes = [];

  @override
  void initState() {
    super.initState();
    _loadQuizzes();
  }

  Future<void> _loadQuizzes() async {
    final data = await _controller.fetchQuizzes();
    setState(() {
      quizzes = data;
    });
  }

  void _addQuiz() async {
    if (nameController.text.isEmpty ||
        scoreController.text.isEmpty ||
        overallScoreController.text.isEmpty) {
      return;
    }

    int score = int.parse(scoreController.text);
    int overallScore = int.parse(overallScoreController.text);
    await _controller.addQuiz(nameController.text, score, overallScore);
    await _loadQuizzes();
    nameController.clear();
    scoreController.clear();
    overallScoreController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 47, 1, 1),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 183, 58, 58),
        ),
        cardColor: Colors.grey[850],
      ),
      child: Scaffold(
       appBar: AppBar(
  title: const Text(
    'Quiz Score Recorder',
    style: TextStyle(
      color: Color.fromARGB(252, 0, 0, 0), // Change this to your desired color
      fontWeight: FontWeight.bold,
    ),
  ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 166, 243, 41),
                  Color.fromARGB(255, 74, 234, 95),
                 
                ],                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddQuizScreen(
                  onQuizAdded: _loadQuizzes,
                ),
              ),
            );
          },
          child: const Icon(Icons.add, color: Colors.white),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
            
              const SizedBox(height: 20),
              Expanded(
                child: quizzes.isEmpty
                    ? const Center(
                        child: Text(
                          "No quizzes added yet",
                          style: TextStyle(color: Colors.white54, fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        itemCount: quizzes.length,
                        itemBuilder: (context, index) {
                          double progress = quizzes[index].score / quizzes[index].overallScore;
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(color: const Color.fromARGB(255, 255, 77, 77).withOpacity(0.5), width: 1),
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    quizzes[index].quizName,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Score: ${quizzes[index].score}/${quizzes[index].overallScore}',
                                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                                  ),
                                  const SizedBox(height: 6),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: LinearProgressIndicator(
                                      value: progress,
                                      backgroundColor: Colors.grey[700],
                                      valueColor: const AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 255, 77, 77)),
                                      minHeight: 10,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        progress >= 0.5 ? "Good Job!" : "Keep Trying!",
                                        style: TextStyle(
                                          color: progress >= 0.5 ? Colors.greenAccent : Colors.redAccent,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      quizzes[index].passed
                                          ? const Icon(Icons.check_circle, color: Colors.greenAccent)
                                          : const Icon(Icons.cancel, color: Colors.redAccent),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
