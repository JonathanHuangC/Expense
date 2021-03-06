import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/model/keepSetting/keep_record.dart';
import 'package:flutter_bookkeeping/util/DbHelper.dart';
import 'package:flutter_bookkeeping/util/constant.dart';

/// FileName: keepDbHelper
/// Author: hjy
/// Date: 2021/8/15 20:31
/// Description:

class KeepDbHelper {
  // 新增
  static Future<KeepRecord> insert(KeepRecord record) async {
    var __db = await DbHelper.instance.db;
    try {
      print(11111);
      var mp = record.toMap();
      print(mp);
      if (mp.containsKey("id")) {
        mp.remove("id");
      }
      record.id = await __db.insert(KeepTable.TABLE_NAME, mp);
      print("record.id---${record.id}");
      print("新增记录成功 id: ${record.id}");
      if (record.recordNumber is String) {
        print('是string类型');
      } else if (record.recordNumber is double) {
        print('double');
      } else {
        print('其他类型');
      }
      print(record.recordNumber);
    } catch (e) {
      print("新增失败");
    }
    return record;
  }

  // 查询全部
  static Future<List<KeepRecord>> queryAll() async {
    var _dbClient = await DbHelper.instance.db;
    List<Map<String, dynamic>> maps =
        await _dbClient.query(KeepTable.TABLE_NAME);
    List<KeepRecord> list = [];
    maps.forEach((value) {
      list.add(KeepRecord.fromMap(value));
    });
    return list;
  }

  //  通过id查询
  static Future<KeepRecord> query(int id) async {
    // 根据id查询成功
    var __db = await DbHelper.instance.db;
    List<Map> maps = await __db
        .query(KeepTable.TABLE_NAME, where: 'id = ?', whereArgs: [id]);
    if (maps.length > 0) return KeepRecord.fromMap(maps.first);

    print("通过id查询成功");
    return null;
  }

  // 查询今日
  static Future<List<KeepRecord>> queryToday() async {
    var __db = await DbHelper.instance.db;
    List<Map<String, dynamic>> maps = await __db.rawQuery(
        "select * from ${KeepTable.TABLE_NAME} where datetime(record_time) between datetime('now','start of day','+1 seconds') and datetime('now','start of day','+1 days','-1 seconds') order by datetime(record_time) desc ");
    List<KeepRecord> list = [];
    maps.forEach((value) {
      list.add(KeepRecord.fromMap(value));
    });
    return list;
  }

  // 查詢本周
  static Future<List<KeepRecord>> queryWeek() async {
    var __db = await DbHelper.instance.db;
    List<Map<String, dynamic>> maps = await __db.rawQuery(
        "select * from ${KeepTable.TABLE_NAME} where strftime('%W', datetime('now')) = strftime('%W',record_time)  order by datetime(record_time) desc");
    List<KeepRecord> list = [];
    maps.forEach((value) {
      list.add(KeepRecord.fromMap(value));
    });
    print(list.length);
    return list;
  }

  // 查询本月
  static Future<List<KeepRecord>> queryMonth() async {
    var __db = await DbHelper.instance.db;
    List<Map<String, dynamic>> maps = await __db.rawQuery(
        "select * from ${KeepTable.TABLE_NAME} where datetime(record_time) between datetime('now','start of month','+1 second') and datetime('now','start of month','+1 month','-1 second') order by datetime(record_time) desc");
    List<KeepRecord> list = [];
    maps.forEach((value) {
      list.add(KeepRecord.fromMap(value));
    });
    print(list.length);
    return list;
  }

  // 查询本年
  static Future<List<KeepRecord>> queryYear() async {
    var __db = await DbHelper.instance.db;
    List<Map<String, dynamic>> maps = await __db.rawQuery(
        "select * from ${KeepTable.TABLE_NAME} where strftime('%Y', datetime('now')) = strftime('%Y', record_time) order by datetime(record_time) desc");
    List<KeepRecord> list = [];
    maps.forEach((value) {
      list.add(KeepRecord.fromMap(value));
    });
    print(list.length);
    return list;
  }

  // 删除全部
  static Future<int> deleteAll() async {
    var __db = await DbHelper.instance.db;
    print("删除全部");
    return await __db.delete(KeepTable.TABLE_NAME);
  }

  // 通过id删除
  static Future<int> deleteById(int id) async {
    var __db = await DbHelper.instance.db;
    print('通过id删除成功');
    return await __db.delete(KeepTable.TABLE_NAME,
        where: '${KeepTable.recordId} = ?', whereArgs: [id]);
  }

  // 查詢本周收入及支出
  static Future<double> queryWeekIncome(String type, String cycle) async {
    var __db = await DbHelper.instance.db;
    print("查詢收入及支出");
    String sql = "";
    if(cycle == "W")
       sql = "record_category_num = ? and strftime('%W', datetime('now')) = strftime('%W',record_time)";
    else if (cycle == "Y")
      sql = "record_category_num = ? and  strftime('%Y', datetime('now')) = strftime('%Y', record_time)";
    else if (cycle == "D")
      sql = "record_category_num = ? and  datetime(record_time) between datetime('now','start of day','+1 seconds') and datetime('now','start of day','+1 days','-1 seconds')";
    else
      sql = "record_category_num = ? and  datetime(record_time) between datetime('now','start of month','+1 second') and datetime('now','start of month','+1 month','-1 second')";
    List<Map> maps = await __db
        .query(KeepTable.TABLE_NAME, where: sql, whereArgs: [type]);
    double totalAmount =0.0;
    List<KeepRecord> list = [];
    maps.forEach((value) {
      list.add(KeepRecord.fromMap(value));
    });

    for (int i = 0; i < list.length; i++) {
      KeepRecord record = list[i];
      totalAmount += record.recordNumber.toDouble();
    }
    return totalAmount;
  }
}
