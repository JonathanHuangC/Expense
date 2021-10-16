
import 'package:flutter_bookkeeping/util/constant.dart';

/// FileName: keep_record
/// Author: hjy
/// Date: 2021/8/15 20:16
/// Description:

class KeepRecord {
  //id
  int id;
  // 记录分类名称
  String recordCategoryName;
  // 记录类型
  int recordCategoryNum;
  // 记录的图片
  String recordImage;
  // 记录的钱数
  double recordNumber;
  // 记录的备注
  String recordRemarks;
  // 记录创建的时间
  String recordTime;
  // 紀錄發票號碼
  String recordInvoice;

  KeepRecord(this.recordCategoryName, this.recordCategoryNum, this.recordTime,
      this.recordImage, this.recordRemarks, this.recordNumber,this.recordInvoice,
      {this.id});

  //  格式轉換
  static KeepRecord fromMap(Map<String, dynamic> map) => KeepRecord(
      map[KeepTable.recordCategoryName],
      map[KeepTable.recordCategoryNum],
      map[KeepTable.recordTime],
      map[KeepTable.recordImage],
      map[KeepTable.recordRemarks],
      map[KeepTable.recordNumber],
      map[KeepTable.recordInvoice], //Jonathan 20211011 新增發票號碼
      id: map[KeepTable.recordId]
  );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      KeepTable.recordCategoryName: this.recordCategoryName,
      KeepTable.recordCategoryNum: this.recordCategoryNum,
      KeepTable.recordTime:
      this.recordTime ?? DateTime.now().millisecondsSinceEpoch,
      KeepTable.recordImage: this.recordImage,
      KeepTable.recordRemarks:this.recordRemarks,
      KeepTable.recordNumber:this.recordNumber,
      KeepTable.recordInvoice:this.recordInvoice,//Jonathan 20211011 新增發票號碼
    };
    if (this.id != null) map[KeepTable.recordId] = this.id;
    return map;
  }
}
