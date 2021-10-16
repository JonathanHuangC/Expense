import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/model/keepSetting/keep_record.dart';
import 'package:flutter_bookkeeping/page/home/image_item/image_item.dart';
import 'package:flutter_bookkeeping/page/home/record_item.dart';

class WeekDetail extends StatelessWidget {
  WeekDetail({this.list, this.income, this.outcome});


  final List<KeepRecord> list;
  final double income;
  final double outcome;

  @override
  Widget build(BuildContext context) {

    final List<Widget> items = [
      ImageItem(
        imageUrl: 'assets/home_bg_4.jpg',
        expendQuota: this.income,
        incomeQuota: this.outcome,
      ),
    ];
    double income = 0;
    for (int i = 0; i < list.length; i++) {
      KeepRecord record = list[i];
      items.add(
        RecordItem(
            recordType: record.recordCategoryNum,
            category: record.recordCategoryName,
            remark: record.recordTime,
            imageUrl: record.recordImage,
            quota: record.recordNumber,
            invoice: record.recordInvoice),
      );
    }



    return Scaffold(
      appBar: AppBar(
        title: Text("本周帳單"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.separated(
        itemCount: items.length,
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemBuilder: (BuildContext context, int index) {
          return items[index];
        },
      ),
    );
  }
}
