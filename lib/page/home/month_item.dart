import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/dao/keepDbHelper.dart';
import 'package:flutter_bookkeeping/model/keepSetting/keep_record.dart';
import 'package:flutter_bookkeeping/page/home/month_detail.dart';

class MonthItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    return ListTile(
      title: Text("本月"),
      subtitle: Text("10月1日 - 10月31日"), //Jonathan 月份要改成連動的方式
      leading: Icon(Icons.calendar_view_month, color: Colors.blueAccent),
      trailing: Icon(Icons.arrow_right),
      onTap: () async {
        List<KeepRecord> list = await KeepDbHelper.queryMonth();
        double income = await KeepDbHelper.queryWeekIncome('1','M');
        double outcome = await KeepDbHelper.queryWeekIncome('0','M');
        Navigator.push(context,
            CupertinoPageRoute(builder: (context) => MonthDetail(list: list,income:income,outcome:outcome,)));
      },
    );
  }
}
