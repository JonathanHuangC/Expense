import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/dao/keepDbHelper.dart';
import 'package:flutter_bookkeeping/model/keepSetting/keep_record.dart';
import 'package:flutter_bookkeeping/page/home/week_detail.dart';

class WeekItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("本周"),
      subtitle: Text("10月10日 - 10月16日"), //Jonathan 每周的日期要改為連動
      leading: Icon(Icons.calendar_view_week, color: Colors.orangeAccent),
      trailing: Icon(Icons.arrow_right),
      onTap: () async {
        List<KeepRecord> list = await KeepDbHelper.queryWeek();
        double income = await KeepDbHelper.queryWeekIncome('1','W');
        double outcome = await KeepDbHelper.queryWeekIncome('0','W');
        Navigator.push(context,
            CupertinoPageRoute(builder: (context) => WeekDetail(list: list,income:income,outcome:outcome,)));
      },
    );
  }
}
