import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "TaskApp.db";
  static final _databaseVersion = 1;
  static final table = 'users';
  static final columnId = '_id';
  static final columnEmail = 'email';
  static final columnPassword = 'password';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(
      _databaseName,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnEmail TEXT NOT NULL UNIQUE, -- Mark email as UNIQUE
        $columnPassword TEXT NOT NULL
      )
      ''');
  }

  Future<Map<String, dynamic>?> getUser(String email) async {
    final db = await database;
    final results = await db.query(
      table,
      where: '$columnEmail = ?',
      whereArgs: [email],
    );
    return results.isNotEmpty ? results.first : null;
  }

  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    return await db.insert(
      table,
      user,
      conflictAlgorithm: ConflictAlgorithm.abort, // Prevent duplicate entries
    );
  }
}
