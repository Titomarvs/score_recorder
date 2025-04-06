import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/quiz.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'quizzes.db');
    return await openDatabase(
      path,
      version: 2, // Increment version to trigger upgrade
      onUpgrade: (db, oldVersion, newVersion) {
        if (oldVersion < 2) {
          db.execute(
            'ALTER TABLE quizzes ADD COLUMN passed INTEGER NOT NULL DEFAULT 0',
          );
        }
      },
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE quizzes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            quizName TEXT NOT NULL,
            score INTEGER NOT NULL,
            overallScore INTEGER NOT NULL,
            passed INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  Future<int> insertQuiz(Quiz quiz) async {
    final db = await database;
    print("Inserting Quiz: ${quiz.toMap()}"); // Debugging
    int result = await db.insert('quizzes', quiz.toMap());
    print("Inserted Quiz ID: $result"); // Debugging
    return result;
  }

  Future<List<Quiz>> getQuizzes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('quizzes');
    print("Fetched Quizzes: $maps"); // Debugging
    return List.generate(maps.length, (i) {
      return Quiz.fromMap(maps[i]);
    });
  }
}
