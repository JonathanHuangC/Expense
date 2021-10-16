import 'package:flutter/material.dart';

class RecordItem extends StatelessWidget {
  // 记录类型： 1代表支出, 0代表收入
  final int recordType;

  // 类别
  final String category;

  // 备注
  final String remark;

  // 图片路径
  final String imageUrl;

  // 额度
  final double quota;

  //add by Jonathan 20211014 發票號碼
  final String invoice;

  RecordItem({
    @required this.recordType,
    @required this.category,
    @required this.remark,
    @required this.imageUrl,
    @required this.quota,
    @required this.invoice,
  });

  @override
  Widget build(BuildContext context) {
    print(imageUrl);
    return ListTile(
      title: Text(category),
      subtitle: Text(remark),
      leading: Image.asset(
          imageUrl.length == 0 ? 'assets/chongwumaomi.png' : imageUrl,
          fit: BoxFit.contain),
      trailing: Text(
        //invoice != null ?invoice : quota.toStringAsFixed(1),
        recordType.toString() + '    ' + invoice + '   ' + quota.toStringAsFixed(1),
        style: TextStyle(color: recordType == 1 ? Colors.green : Colors.red),
      ),
    );
  }
}
