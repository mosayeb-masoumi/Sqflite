import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_flutter/list_object_db/model/combine_model.dart';


class CombineDatabase{

  static final CombineDatabase instance = CombineDatabase._init();
  static Database? _database;
  CombineDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('combine.db');
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


    await db.execute('''
CREATE TABLE $tableCombine ( 
  ${CombineModelFields.id} $idType, 
  ${CombineModelFields.title} $textType,
  ${CombineModelFields.createdTime} $textType,
  ${CombineModelFields.detailModel} $textType,
  ${CombineModelFields.detailList} $textType
  )
''');
  }

//   Future _createDB(Database db, int version) async {
//     final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
//     final textType = 'TEXT NOT NULL';
//
//
//     await db.execute('''
// CREATE TABLE $tableCombine (
//   ${CombineModelFields.id} $idType,
//   ${CombineModelFields.title} $textType,
//   ${CombineModelFields.createdTime} $textType,
//   ${CombineModelFields.detailModel} $textType,
//   ${CombineModelFields.detailList} $textType,
//   )
// ''');
//   }

  Future<CombineModel> create(CombineModel combineModel) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableCombine, combineModel.toJson());
    return combineModel.copy(id: id);
  }

  Future<CombineModel> readUser(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableCombine,
      columns: CombineModelFields.values,
      where: '${CombineModelFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return CombineModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<CombineModel>> readAllUsers() async {
    final db = await instance.database;

    final orderBy = '${CombineModelFields.createdTime} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');
    final result = await db.query(tableCombine, orderBy: orderBy);
    return result.map((json) => CombineModel.fromJson(json)).toList();
  }

  // Future<CombineModel> readAllObject() async {
  //   final db = await instance.database;
  //   final result = await db.query(tableCombine);
  //   var x = json.decode(result.toString());
  //   var className = CombineModel.fromJson(x);
  //   return  className;
  // }




  Future<int> update(CombineModel user) async {
    final db = await instance.database;

    return db.update(
      tableCombine,
      user.toJson(),
      where: '${CombineModelFields.id} = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableCombine,
      where: '${CombineModelFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAll() async {
    final db = await instance.database;

    return await db.delete(
      tableCombine,
    );
  }


  Future close() async {
    final db = await instance.database;

    db.close();
  }

}