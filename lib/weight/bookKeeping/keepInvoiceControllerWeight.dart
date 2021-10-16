// ignore: camel_case_types
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/page/bookKeeping/calculator.dart';

// ignore: must_be_immutable
class KeepInvoiceControllerWeight extends StatefulWidget{

  TextEditingController keepInvoiceController = TextEditingController();

  KeepInvoiceControllerWeight(this.keepInvoiceController);
  @override
  State<StatefulWidget> createState() {
    return new _KeepInvoiceControllerWeightState(this.keepInvoiceController);
  }

}
class _KeepInvoiceControllerWeightState extends State<KeepInvoiceControllerWeight> {
  TextEditingController keepInvoiceController = TextEditingController();
  //  默认的一些配置
  final marginSetting = EdgeInsets.fromLTRB(0, 15, 0, 0);
  FocusNode _commentFocus = FocusNode();


  _KeepInvoiceControllerWeightState(this.keepInvoiceController) :super();


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: marginSetting, //外边距，父容器本身相对外部容器的移动
      child: Container(
        height: 50,
        constraints: BoxConstraints(maxHeight: 56, minHeight: 56),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFE8E8E8),
              width: 2,
            ),
          ),
        ),
        child: TextField(
          controller: keepInvoiceController,
          style: TextStyle(fontSize: 15, color: Colors.black87), //文字大小、颜色
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              /*边角*/
              borderRadius: BorderRadius.all(
                Radius.circular(20), //边角为30
              ),
              borderSide: BorderSide(
                color: Colors.blue, //边线颜色为藍色
                width: 2, //边线宽度为2
              ),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.lightBlue, //边框颜色为绿色
                  width: 2, //宽度为5
                )),
            labelText: "請輸入發票號碼",
            helperStyle: TextStyle(color: Colors.red),
            prefixIconConstraints: BoxConstraints(),
            prefixIcon: InkWell(
              child: Container(
                child: Image.asset(
                  'assets/licaitouzi.png',
                  width: 30,
                  height: 40,
                ),
              ),
              onTap: () async {
                showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Column(
                        children: [Expanded(child: Calculator(keepInvoiceController))],
                      );
                    });
                // final result = await Navigator.pushNamed(context);
              },
            ),
          ),
        ),
      ),
    );
  }

}
