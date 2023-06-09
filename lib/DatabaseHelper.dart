import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

import 'package:thejournal/Model/ChannelModel.dart';




class DbHelper{
  static Database? _db;

  static const DB_Name = "channel.db";
  static const String Table_Journal = "channel";
  static const int Version = 1;

  static const String J_ChannelID = 'channel_id';
  static const String J_ChannelName = 'channel_name';
  static const String J_SpecialName = 'special_name';
  static const String J_ChannelLink = 'channel_link';

  Future<Database?> get db async {
    // ignore: unnecessary_null_comparison
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();

    String path = "";
    if (Platform.isIOS) {
      directory = await getApplicationSupportDirectory();
      if (!directory.parent.path.endsWith('/')) {
        path = directory.parent.path + '/' + 'journal.db';
      } else {
        path = directory.parent.path + 'journal.db';
      }
    } else {
      path = directory.parent.path + '/databases' + '/journal.db';

    }

    ///change DB VERSION 6 / 7
    var notesDatabase = await openDatabase(path,
        version: 1, onCreate: _onCreate);
    return notesDatabase;
  }
  _onCreate(Database db, int intVersion) async {
    await db.execute("CREATE TABLE $Table_Journal ("
        " $J_ChannelID INTEGER PRIMARY KEY AUTOINCREMENT, "
        " $J_ChannelName TEXT, "
        " $J_SpecialName TEXT,"
        " $J_ChannelLink TEXT"
        ")");

  }
  // insert data
  Future<int> insertChannels(List<ChannelModel> channelModel) async {
    int result = 0;
    final Database db = await initDb();
    for (var channel in channelModel) {
      result = await db.insert(Table_Journal, channel.toJsonDB(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    print("inserted ${result}");
    retrieveChannels();
    return result;
  }
  Future<List<ChannelModel>> retrieveChannels() async {
    final Database db = await initDb();
    final List<Map<String, Object?>> queryResult = await db.query(Table_Journal);
    print("row element${queryResult}");
    return queryResult.map((e) => ChannelModel.fromJsonDBforDetails(e)).toList();
  }
  Future<void> deleteChannel(int id) async {
    final db = await initDb();
    await db.delete(
      Table_Journal,
      where: "channel_id = ?",
      whereArgs: [id],
    );
  }
  Future<void> updateChannels(ChannelModel channelModel) async {
    final db = await initDb();
    //update a specific student
    print("the name is"+ channelModel.channelName.toString());
    await db.update(Table_Journal, channelModel.toJsonDB(),
        where: '$J_ChannelID=?', whereArgs: [channelModel.channelId]);
    /*await db.rawUpdate(
      //table name
      Table_Journal,
      //convert student object to a map
      //ensure that the student has a matching email
      channelModel.toJsonDB,
      //ensure that the student has a matching email
      where: 'channel_id = ?','channel_name = ?','channel_link = ?','special_name = ?',
      //argument of where statement(the email we want to search in our case)
      whereArgs: [channelModel.channelId,channelModel.channelName,channelModel.channelLink,channelModel.specialName],
    );*/
  }
}