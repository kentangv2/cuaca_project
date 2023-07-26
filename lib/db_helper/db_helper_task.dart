import 'package:NewsLine/ui/task/task.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseHelper {
  static final _databaseName = 'task_database.db';
  static final _databaseVersion = 1;

  static final table = 'task';

  static final columnId = '_id';
  static final columnTitle = 'title';
  static final columnTask = 'task';
  static final columnCategory = 'category';

  static late Database _database;

  static Future<void> initializeDatabase() async {
    final documentsDirectory = await getDatabasesPath();
    final path = join(documentsDirectory, _databaseName);

    _database = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnTitle TEXT NOT NULL,
            $columnTask TEXT NOT NULL,
            $columnCategory TEXT NOT NULL
          )
        ''');
      },
    );
  }

  

  static Future<int> addTask(Task task) async {
    await initializeDatabase();

    final Map<String, dynamic> row = {
      columnTitle: task.title,
      columnTask: task.task,
      columnCategory: task.category,
    };

    return _database.insert(table, row);
  }

  static Future<List<Task>> getTasks() async {
    await initializeDatabase();

    final List<Map<String, dynamic>> maps = await _database.query(table);

    return List.generate(maps.length, (index) {
      return Task(
        id: maps[index][columnId],
        title: maps[index][columnTitle],
        task: maps[index][columnTask],
        category: maps[index][columnCategory],
      );
    });
  }
static Future<bool> updateTask(Task task) async {
    await initializeDatabase();

    final Map<String, dynamic> row = {
      columnTitle: task.title,
      columnTask: task.task,
      columnCategory: task.category,
    };

    int rowsUpdated = await _database.update(
      table,
      row,
      where: '$columnId = ?',
      whereArgs: [task.id],
    );

    return rowsUpdated > 0;
  }

  static Future<bool> deleteTask(Task task) async {
    await initializeDatabase();

    int rowsDeleted = await _database.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [task.id],
    );

    return rowsDeleted > 0;
  }
}
