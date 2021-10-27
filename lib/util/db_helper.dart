import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper
{
  Database? _db;
  static final _dbName = 'login';

  //private constructor of class
  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  Future<Database> get db async
  {
      if(_db == null)
          _db = await initDB();
      return _db!;
  }

  initDB() async
  {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path,version: 2, onCreate: _onCreate);
  }



  _onCreate(Database db, int version) async
  {
    await db.execute(
      '''
        Create Table Users(
        id Integer primary key autoincrement,
        username Text,
        email Text,
        password Text
        );
      '''
    );
  }

  Future<int> insert(String table, Map<String, dynamic> row) async
  {
    if(table == null || table == '')
      {
        return 0;
      }
    else
      {
        Database database = await instance.db;
        int id = await database.insert(table, row);
        print('id : $id');
        return id;
      }
  }
}