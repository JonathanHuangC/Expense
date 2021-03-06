import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/dao/categoryDbHelper.dart';
import 'package:flutter_bookkeeping/dao/keepDbHelper.dart';
import 'package:flutter_bookkeeping/model/keepSetting/keep_record.dart';
import 'package:flutter_bookkeeping/test/bookKeeping_database_test.dart';
import 'package:flutter_bookkeeping/weight/bookKeeping/beiZhuTextControllerWeight.dart';
import 'package:flutter_bookkeeping/weight/bookKeeping/keepTextControllerWeight.dart';
import 'package:flutter_bookkeeping/weight/bookKeeping/KeepInvoiceControllerWeight.dart';
import 'package:flutter_bookkeeping/weight/bookKeeping/timeTextControllerWeight.dart';
import 'package:flutter_pickers/pickers.dart';
import 'calculator.dart';
import 'package:flutter_bookkeeping/util/DbHelper.dart';
import 'package:flutter_bookkeeping/model/categorySetting/category.dart';

import '../../constantWr.dart';
import 'category_setting_main.dart';

/*
* 记账支出的页面
*
*
*
*
* */
class KeepExpenditure extends StatefulWidget {
  final DbHelper categoryProvider = new DbHelper();

  @override
  State<StatefulWidget> createState() {
    return new _KeepExpenditureState();
  }
}

class _KeepExpenditureState extends State<KeepExpenditure> {
  // 默认的图片编号为1

  var curImageNumString;
  var curCategoryName;
  var curColor = Colors.black12;
  String _key = '';
  // 是否有变化的分类管理
  bool isOnTap = false;

  // 記帳金額
  final _keepTextController = TextEditingController();

  // 20211011 add by Jonathan 發票號碼
  final _keepInvoiceController = TextEditingController();

  //  備註
  final _beiZhuTextController = TextEditingController();

  //  日期
  final _timeTextController = TextEditingController();


  double _keepText = 0.00;
  String _beiZhuText = '';
  String _timeText = '';
  // 默认的
  List<Catetory> _historyWords = CategoryImage.expenditureCategory;
  // List<Catetory> _historyWords = [];





  // String get calculator => null;

//  初始化
  @override
  void initState() {
    super.initState();
    setState(() {
      _keepText = 0.00;
      _beiZhuText = _beiZhuTextController.text;
      _timeText = _timeTextController.text;
      curImageNumString = '';
      curCategoryName = '';
      _getAllDataFromDb();
    });
  }

  _getAllDataFromDb() async {
    List<Catetory> _tempList  =  await widget.categoryProvider.queryByCategoryBelong(1) ;
    if(_tempList.length > _historyWords.length) {
       _historyWords =  _tempList;
    }
    print(_historyWords);
  }

  @override
  Widget build(BuildContext context) {
    // _getAllDataFromDb();
    return Scaffold(
      backgroundColor: Colors.white54,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 15, right: 15, top: 20),
        child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 700),
            child: Column(
              children: <Widget>[
                ImageListWidget(),
                KeepTextControllerWeight(_keepTextController),
                KeepInvoiceControllerWeight(_keepInvoiceController), // add by Jonathan 20211013 加入發票號碼
                TimeTextControllerWeight(_timeTextController),
                BeiZhuTextControllerWeight(_beiZhuTextController),
                _storeButton(),
                // _buildButton()
              ],
            )),
      ),
    );
  }

  // 图片展示
  Widget ImageListWidget() {
    return Wrap(
      spacing: 23, //主轴上子控件的间距
      runSpacing: 10, //交叉轴上子控件之间的间距
      children: _listView(), //要显示的子控件集合
    );
  }

  // 图片组件
  List<Widget> _listView() {
    List<Widget> listWidget = [];
    // 访问数据库，得到所有的分类对象
    _historyWords.forEach((e) => {
      print(e),
      listWidget.add(listItem(e))});
    return listWidget;
  }

  Widget listItem(item) {
    return InkWell(
        onTap: () {
          setState(() {
            // // 更新全局所选的id
            curImageNumString = item.category_inmage_num;
            curCategoryName = item.category_name;
            _key = item.category_name;
            print(_key);
            print(curImageNumString);
            print(curCategoryName);
          });
        },
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
                decoration: new BoxDecoration(
                  // 点击之后的
                  color: _key == item.category_name ? Colors.black12 : Colors.white54,
                ),
                child: Column(children: <Widget>[
                  Image.asset(
                    item.category_inmage_num,
                    width: 60,
                    height: 50,
                  ),
                  Text(
                    item.category_name,
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Color.fromARGB(255, 22, 22, 78),
                        // decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.solid),
                  ),
                ]))));
  }


  // 保存按钮
  Widget _storeButton() {
    return Container(
        margin: EdgeInsets.only(left: 100, right: 15, top: 20),
        child: Row(
          children: [
            FlatButton(
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CategoryHomePage()));
              },
              child: Text("分类管理"),
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.white,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(15)),
            ),
            FlatButton(
              onPressed: () async {
                // 存储所有的数据到数据库
                print(curImageNumString);
                print(curCategoryName);

                double _keepText =
                double.parse(_keepTextController.text) == 0.00
                        ? 0.00
                        : double.parse(_keepTextController.text);
                String _beiZhuText = _beiZhuTextController.text == ''
                    ? '无'
                    : _beiZhuTextController.text;
                String _InvoiceText = _keepInvoiceController.text == ''
                    ? 'Non'
                    : _keepInvoiceController.text;

                print(_beiZhuText);
                String _timeText = _timeTextController.text;
                print(_timeText);

                // modify by Jonathan 新增發票號碼
                KeepRecord keepRecord = new KeepRecord(curCategoryName, 1,
                    _timeText, curImageNumString, _beiZhuText, _keepText, _InvoiceText);
                var id = await KeepDbHelper.insert(keepRecord);
                // 清空输入框
                _keepTextController.clear();
                _keepInvoiceController.clear();
                _timeTextController.clear();
                _beiZhuTextController.clear();

                // 跳转返回另外一个页面
              },
              child: Text("保存"),
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.white,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(15)),
            ),

          ],
        ));
  }
}
