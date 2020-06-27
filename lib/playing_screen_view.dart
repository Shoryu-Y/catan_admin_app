import 'package:flutter/material.dart';
import 'package:catanadminapp/duel_state.dart';
import 'package:provider/provider.dart';

class PlayingScreenPage extends StatelessWidget {
  const PlayingScreenPage();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: PlayingScreenStfulPage(),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 0),
                  child: ButtonTheme(
                    minWidth: 200.0,
                    height: 40.0,
                    child: RaisedButton(
                      child: Text(
                        'DICE ROLL!',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: (){
                        Provider.of<DuelStateModel>(context, listen: false).playDiceSound();
                        Provider.of<DuelStateModel>(context, listen: false).onPressedDiceButton();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlayingScreenStfulPage extends StatefulWidget {
  const PlayingScreenStfulPage();
  @override
  _PlayingScreenStfulPageState createState() => _PlayingScreenStfulPageState();
}

class _PlayingScreenStfulPageState extends State<PlayingScreenStfulPage> {
  @override
  Widget build(BuildContext context) {
    DuelStateModel reading = Provider.of<DuelStateModel>(context, listen: false);
    return Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              reading.playerNameList[reading.playerCount],
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: <Widget>[
              Text(
                '残り時間',
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                '${Provider.of<DuelStateModel>(context).minutesView}:${Provider.of<DuelStateModel>(context).secondsView}',
                style: Theme.of(context).textTheme.headline2,
              ),
            ],
          ),
        ),
        Expanded(
            flex: 2,
            child: Column(
              children: <Widget>[
                Text(
                  '${Provider.of<DuelStateModel>(context).diceSum}',
                  style: Theme.of(context).textTheme.headline2,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: reading.showDiceImage(reading.diceValue1),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: reading.showDiceImage(reading.diceValue2),
                      ),
                    ),
                  ],
                ),
              ],
            )
        ),
      ],
    );
  }
}

