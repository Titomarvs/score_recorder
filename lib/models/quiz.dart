class Quiz {
  int? id;
  String quizName;
  int score;
  int overallScore;
  bool passed;

  Quiz({
    this.id,
    required this.quizName,
    required this.score,
    required this.overallScore,
    bool? passed, // Allow optional passed field
  }) : passed = passed ?? ((score / overallScore) * 100 >= 70);

  // Convert Quiz object to a Map for database storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quizName': quizName,
      'score': score,
      'overallScore': overallScore,
      'passed': passed ? 1 : 0,
    };
  }

  // Convert a Map from the database back to a Quiz object
  factory Quiz.fromMap(Map<String, dynamic> map) {
    return Quiz(
      id: map['id'],
      quizName: map['quizName'],
      score: map['score'],
      overallScore: map['overallScore'],
      passed: map['passed'] == 1,
    );
  }
}
