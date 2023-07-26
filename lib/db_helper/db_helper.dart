import 'package:NewsLine/ui/contact/contact.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseHelper {
  static final _databaseName = 'contact_database.db';
  static final _databaseVersion = 1;

  static final table = 'contacts';

  static final columnId = '_id';
  static final columnName = 'name';
  static final columnPhoneNumber = 'phoneNumber';
  static final columnEmail = 'email';

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
            $columnName TEXT NOT NULL,
            $columnPhoneNumber TEXT NOT NULL,
            $columnEmail TEXT NOT NULL
          )
        ''');
      },
    );
  }

  

  static Future<int> addContact(Contact contact) async {
    await initializeDatabase();

    final Map<String, dynamic> row = {
      columnName: contact.name,
      columnPhoneNumber: contact.phoneNumber,
      columnEmail: contact.email,
    };

    return _database.insert(table, row);
  }

  static Future<List<Contact>> getContacts() async {
    await initializeDatabase();

    final List<Map<String, dynamic>> maps = await _database.query(table);

    return List.generate(maps.length, (index) {
      return Contact(
        id: maps[index][columnId],
        name: maps[index][columnName],
        phoneNumber: maps[index][columnPhoneNumber],
        email: maps[index][columnEmail],
      );
    });
  }
static Future<bool> updateContact(Contact contact) async {
    await initializeDatabase();

    final Map<String, dynamic> row = {
      columnName: contact.name,
      columnPhoneNumber: contact.phoneNumber,
      columnEmail: contact.email,
    };

    int rowsUpdated = await _database.update(
      table,
      row,
      where: '$columnId = ?',
      whereArgs: [contact.id],
    );

    return rowsUpdated > 0;
  }

  static Future<bool> deleteContact(Contact contact) async {
    await initializeDatabase();

    int rowsDeleted = await _database.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [contact.id],
    );

    return rowsDeleted > 0;
  }
}
