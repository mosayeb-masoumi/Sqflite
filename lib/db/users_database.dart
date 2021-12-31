import 'package:sqflite/sqflite.dart';
import 'package:sqflite_flutter/model/user_model.dart';
import 'package:path/path.dart';


class UsersDatabase{

  static final UsersDatabase instance = UsersDatabase._init();
  static Database? _database;
  UsersDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('users.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableUsers ( 
  ${UserModelFields.id} $idType, 
  ${UserModelFields.isMarried} $boolType,
  ${UserModelFields.phoneNumber} $integerType,
  ${UserModelFields.name} $textType,
  ${UserModelFields.family} $textType,
  ${UserModelFields.createdTime} $textType
  )
''');
  }

  Future<UserModel> create(UserModel userModel) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableUsers, userModel.toJson());
    return userModel.copy(id: id);
  }

  Future<UserModel> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableUsers,
      columns: UserModelFields.values,
      where: '${UserModelFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return UserModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<UserModel>> readAllUsers() async {
    final db = await instance.database;

    final orderBy = '${UserModelFields.createdTime} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableUsers, orderBy: orderBy);

    return result.map((json) => UserModel.fromJson(json)).toList();
  }

  Future<int> update(UserModel user) async {
    final db = await instance.database;

    return db.update(
      tableUsers,
      user.toJson(),
      where: '${UserModelFields.id} = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableUsers,
      where: '${UserModelFields.id} = ?',
      whereArgs: [id],
    );
  }


  Future close() async {
    final db = await instance.database;

    db.close();
  }

}