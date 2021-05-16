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
                    ? '目標金額 : ${state.targetMoneyInfoData.targetMoney.toString()}'
                    : '0',
                style: TextStyle(
                  fontSize: 26,
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
                '合計金額 : ${state.totalAddMoney.toString()}',
                style: TextStyle(
                  fontSize: 26,
                ),
              ),
            ),
            Divider(height: 0, color: Colors.red, indent: 20, endIndent: 20),
            Container(
              alignment: Alignment.center,
              height: 100,
              child: Text(
                '差額金額 : $_differenceMoney',
                style: TextStyle(
                  fontSize: 26,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
