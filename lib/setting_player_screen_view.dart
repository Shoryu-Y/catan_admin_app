import 'package:catanadminapp/duel_state.dart';
import 'package:catanadminapp/setting_timelimit_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPlayerScreenPage extends StatefulWidget {
  const SettingPlayerScreenPage();
  @override
  _SettingPlayerScreenPageState createState() => _SettingPlayerScreenPageState();
}

class _SettingPlayerScreenPageState extends State<SettingPlayerScreenPage> {
  final List<int> _numOfPlayer = [4, 3, 2];
  TextEditingController _controller;
  static TextEditingController _controller1;
  static TextEditingController _controller2;
  static TextEditingController _controller3;
  static TextEditingController _controller4;

  List<TextEditingController> _textControllerList;

  @override
  void initState() {
    super.initState();
    _controller1 = TextEditingController();
    _controller2 = TextEditingController();
    _controller3 = TextEditingController();
    _controller4 = TextEditingController();
  }
  @override
  void dispose() {
    super.dispose();
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _textControllerList = [_controller1, _controller2, _controller3, _controller4];

    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'プレイヤーの名前を\n決定しましょう！',
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (BuildContext context, int index){
                  return _playerNameTextField(index);
                }
            ),
            Align(
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
                      _submitPlayersName();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context){
                            return SettingTimerScreenPage();
                          }
                        )
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget _playerNameTextField(index){
    final String playerNameLabel = 'Player ${index + 1}';
    _controller = _textControllerList[index];

    return Padding(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: _controller,
        maxLines: 1,
        onChanged: (String value){
          Provider.of<DuelStateModel>(context, listen: false).changeNextButtonTextAtPlayerNameScreen(value);
        },
        decoration: InputDecoration(
          hintText: playerNameLabel,
          labelText: playerNameLabel,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  void _submitPlayersName(){
    int playerIndex = 0;
    _textControllerList.forEach((controller) {
      Provider.of<DuelStateModel>(context, listen: false).inputPlayerNames(controller.text, playerIndex);
      playerIndex++;
    });
    print(Provider.of<DuelStateModel>(context, listen: false).playerNameList);
  }
}
