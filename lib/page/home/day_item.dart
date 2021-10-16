import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/page/home/day_detail.dart';
import 'package:flutter_bookkeeping/dao/keepDbHelper.dart';
import 'package:flutter_bookkeeping/model/keepSetting/keep_record.dart';

class DayItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("今日"),
      subtitle: Text("無"), //Jonathan 這段要改成連動數字
      leading: Icon(Icons.calendar_view_day, color: Colors.lightBlue),
      trailing: Icon(Icons.arrow_right),
      onTap: () async {
        List<KeepRecord> list = await KeepDbHelper.queryToday();
        double income = await KeepDbHelper.queryWeekIncome('1','D');
        double outcome = await KeepDbHelper.queryWeekIncome('0','D');
        Navigator.push(context,
            CupertinoPageRoute(builder: (context) => DayDetail(list: list,income:income,outcome:outcome,)));
      },
    );
  }
}
