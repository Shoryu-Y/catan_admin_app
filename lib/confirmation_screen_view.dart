import 'package:flutter/material.dart';
import 'package:catanadminapp/duel_state.dart';
import 'package:provider/provider.dart';
import 'package:catanadminapp/playing_screen_view.dart';

class ConfirmScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      Text(
                        '制限時間',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text(
                        '${Provider.of<DuelStateModel>(context, listen: false).minutesView}:${Provider.of<DuelStateModel>(context, listen: false).secondsView}',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          '遊ぶ順番',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 4,
                          itemBuilder: (BuildContext context, int index){
                            return Center(
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    '${Provider.of<DuelStateModel>(context, listen: false).playerNameList[index]}',
                                    style: index == 0 ? Theme.of(context).textTheme.headline3 : Theme.of(context).textTheme.headline5,
                                  ),
                                ),
                            );
                          }
                      ),
                    ],
                  ),
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
                                'スタート！',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              color: Colors.blue,
                              onPressed: (){
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (BuildContext context){
                                          return PlayingScreenPage();
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
