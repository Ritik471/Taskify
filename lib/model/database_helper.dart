import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "TaskApp.db";
  static final _databaseVersion = 2;

  // User table details
  static final usersTable = 'users';
  static final columnUserId = '_id';
  static final columnEmail = 'email';
  static final columnPassword = 'password';

  // Task table details
  static final tasksTable = 'tasks';
  static final columnTaskId = 'task_id';
  static final columnTitle = 'title';
  static final columnDescription = 'description';
  static final columnColor = 'color';
  static final columnDate = 'date';
  static final columnTime = 'time';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    return await openDatabase(
      _databaseName,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  // Creating tables for users and tasks
  Future<void> _onCreate(Database db, int version) async {
    // Create the users table
    await db.execute('''
      CREATE TABLE $usersTable (
        $columnUserId INTEGER PRIMARY KEY,
        $columnEmail TEXT NOT NULL UNIQUE,
        $columnPassword TEXT NOT NULL
      )
    ''');

    // Create the tasks table
    await db.execute('''
      CREATE TABLE $tasksTable (
        $columnTaskId INTEGER PRIMARY KEY,
        $columnTitle TEXT NOT NULL,
        $columnDescription TEXT NOT NULL,
        $columnColor INTEGER NOT NULL,
        $columnDate TEXT NOT NULL,
        $columnTime TEXT NOT NULL DEFAULT 'Time not set'
      )
    ''');
  }

  // Handles schema upgrades
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      // Add the columnTime field if missing or recreate the table
      await db.execute('DROP TABLE IF EXISTS $tasksTable');
      await db.execute('''
        CREATE TABLE $tasksTable (
          $columnTaskId INTEGER PRIMARY KEY,
          $columnTitle TEXT NOT NULL,
          $columnDescription TEXT NOT NULL,
          $columnColor INTEGER NOT NULL,
          $columnDate TEXT NOT NULL,
          $columnTime TEXT NOT NULL DEFAULT 'Time not set'
        )
      ''');
    }
  }

  // User-related methods
  Future<Map<String, dynamic>?> loginUser(String email, String password) async {
    final db = await database;
    final results = await db.query(
      usersTable,
      where: '$columnEmail = ? AND $columnPassword = ?',
      whereArgs: [email, password],
    );
    return results.isNotEmpty ? results.first : null;
  }

  Future<Map<String, dynamic>?> getUser(String email) async {
    final db = await database;
    final results = await db.query(
      usersTable,
      where: '$columnEmail = ?',
      whereArgs: [email],
    );
    return results.isNotEmpty ? results.first : null;
  }

  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    return await db.insert(
      usersTable,
      user,
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  // Task-related methods
  Future<int> insertTask(Map<String, dynamic> task) async {
    final db = await database;
    return await db.insert(
      tasksTable,
      task,
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  Future<List<Map<String, dynamic>>> getTasksByDate(String date) async {
    final db = await database;
    return await db.query(
      tasksTable,
      where: '$columnDate = ?',
      whereArgs: [date],
    );
  }

  Future<List<Map<String, dynamic>>> getAllTasks() async {
    final db = await database;
    return await db.query(tasksTable);
  }

  Future<int> deleteTask(int taskId) async {
    final db = await database;
    return await db.delete(
      tasksTable,
      where: '$columnTaskId = ?',
      whereArgs: [taskId],
    );
  }
}
