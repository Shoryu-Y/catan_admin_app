import 'package:catanadminapp/duel_state.dart';
import 'package:catanadminapp/playing_screen_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:catanadminapp/confirmation_screen_view.dart';

class SettingTimerScreenPage extends StatefulWidget {
  @override
  _SettingTimerScreenPageState createState() => _SettingTimerScreenPageState();
}

class _SettingTimerScreenPageState extends State<SettingTimerScreenPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Text(
                    '1ターンの制限時間を\n設定しますか？',
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  '${Provider.of<DuelStateModel>(context).minutesView}:${Provider.of<DuelStateModel>(context).secondsView}',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              Expanded(
                flex: 2,
                child: CupertinoTimerPicker(
                  mode: CupertinoTimerPickerMode.ms,
                  secondInterval: 10,
                  onTimerDurationChanged: (value) {
                    Provider.of<DuelStateModel>(context, listen: false).setTimer(value);
                    Provider.of<DuelStateModel>(context, listen: false).changeNextButtonTextAtTimerScreen();
                    print(Provider.of<DuelStateModel>(context, listen: false).timerDuration);
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: ButtonTheme(
                            minWidth: 120,
                            child: FlatButton(
                              child: Text(
                                '戻る',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              color: Colors.blue,
                              onPressed: (){
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: ButtonTheme(
                            minWidth: 120,
                            child: FlatButton(
                              child: Text(
                                Provider.of<DuelStateModel>(context).nextButtonText,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              color: Colors.blue,
                              onPressed: (){
                                Provider.of<DuelStateModel>(context, listen: false).shufflePlayerOrder();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context){
                                      return ConfirmScreenPage();
                                    }
                                  )
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
