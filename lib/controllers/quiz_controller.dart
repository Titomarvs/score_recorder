import '../models/quiz.dart';
import '../services/database_helper.dart';

class QuizController {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> addQuiz(String name, int score, int overallScore) async {
    Quiz newQuiz = Quiz(
      quizName: name,
      score: score,
      overallScore: overallScore,
    );
    print("Adding Quiz: ${newQuiz.toMap()}"); // Debugging
    await _dbHelper.insertQuiz(newQuiz);
  }

  Future<List<Quiz>> fetchQuizzes() async {
    List<Quiz> quizzes = await _dbHelper.getQuizzes();
    print(
      "Fetched Quizzes: ${quizzes.map((q) => q.toMap()).toList()}",
    ); // Debugging
    return quizzes;
  }
}
