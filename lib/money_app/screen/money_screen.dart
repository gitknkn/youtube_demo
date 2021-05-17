import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_demo/money_app/screen/add_money_form.dart';
import 'package:youtube_demo/money_app/screen/money_screen_statenotifier.dart';
import 'package:youtube_demo/money_app/screen/target_money_form.dart';

class MoneyScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final state = watch(moneyStateNotifier.state);
    var _differenceMoney = state.differenceMoney;
    var _totalMoney = state.totalAddMoney;
    // var _targetMoney = state.targetMoneyInfoData.targetMoney;

    return Scaffold(
      appBar: AppBar(
        title: Text('メイン画面'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('目標入力画面'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return TargetMoneyForm();
                    },
                  ),
                );
              },
            ),
            ListTile(
              title: Text('貯金入力画面'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return CurrentMoneyForm();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              alignment: Alignment.center,
              height: 100,
              child: Text(
                state.targetMoneyInfoData != null
                    ? '目標金額 : ${state.targetMoneyInfoData.targetMoney.toString()}円'
                    : '0',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
            Divider(
                height: 0,
                color: Colors.red,
                indent: 20,
                endIndent: 20,
                thickness: 2),
            Container(
              alignment: Alignment.center,
              height: 100,
              child: Text(
                '合計金額 : $_totalMoney円',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
            Divider(height: 0, color: Colors.red, indent: 20, endIndent: 20),
            Container(
              alignment: Alignment.center,
              height: 100,
              child: Text(
                state.isMessageDialog
                    ? '目標金額達成です。'
                        '\nおめでとうございます！'
                    : '差額金額 : $_differenceMoney円',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),

            /// ここに配置したら、add_money_form側で表示されるようになった？？
            state.isMessageDialog
                ? Center(child: _createShowDialog(context))
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget _createShowDialog(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        return showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text('目標金額達成！'),
              content: Text('おめでとうございます'),
              actions: [
                ElevatedButton(
                  child: Text('閉じる'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          },
        );
      },
    );
  }
}
