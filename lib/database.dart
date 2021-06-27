import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutt/user_info.dart';

class DatabaseHelper {
  Database database;
  String tableName = "std";
  UserInfo userInfo;

  Future init() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, "userdbs.db");

    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
              'create table $tableName (id integer primary key autoincrement,topic text, name text, day text, date text, gmail text, value text)');
          print('Table Created');
        });
  }

  Future insertdata(UserInfo userInfo) async {
    await database.transaction((txn) async {
      await txn.rawInsert(

          'insert into $tableName (topic,name,day,date,gmail,value) values (?,?,?,?,?,?)',
          [
            userInfo.topic,
            userInfo.name,
            userInfo.day,
            userInfo.date,
            userInfo.gmail,
            userInfo.inputValue,
          ]);
      print("Data Inserted ......");
    });
  }

  Future<List<UserInfo>> fetchData() async {
    List<UserInfo> userInfoList = [];
    await database.transaction((txn) async {
      List<Map> mapList = await txn.rawQuery("select * from $tableName");
      print("Data is:  ...... ");
      mapList.forEach((map) {
        int id = map["id"];
        String topic = map["topic"];
        String name = map['name'];
        String day = map['day'];
        String date = map['date'];
        String gmail = map['gmail'];
        String value = map['value'];
        UserInfo userInfo = UserInfo(topic, name, day, date, gmail, value, id: id);
        userInfoList.add(userInfo);
      });
    });
    return userInfoList;


  }

  Future deleteRecord(int id) async {
    await database.transaction((txn) async {
      await txn.rawDelete('delete from $tableName where id= ?', [id]);
      print("");
    });
  }
  //"delete from tableName where topic = "abc"

  void closeDb() {
    database.close();
  }
}