import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'package:quiver/async.dart';
import 'package:soundpool/soundpool.dart';
import 'package:flutter/services.dart';

class DuelStateModel with ChangeNotifier{
  String nextButtonText = '入力せず次へ';
  List<String> playerNameList = ['Player 1', 'Player 2', 'Player 3', 'Player 4'];

  Duration timerDuration = Duration.zero;
  int timerSecond = 0;
  int defaultMinutes;
  int defaultSeconds;
  String minutesView = '--';
  String secondsView = '--';

  Random random = Random();
  int diceValue1 = 1;
  int diceValue2 = 1;
  int diceSum = 2;

  CountdownTimer _countdownTimer;
  StreamSubscription<CountdownTimer> sub;
  bool isTimerRunning = false;

  int playerCount = 0;

  Soundpool soundPool;
  int diceSoundId;
  int alarmSoundId;
  int diceSoundStreamId;
  int alarmSoundStreamId;

  void inputPlayerNames(String playerName, int index){
    if(playerName != ''){
      playerNameList[index] = playerName;
    }else{
      playerNameList[index] = 'Player ${index + 1}';
    }
  }

  void changeNextButtonTextAtPlayerNameScreen(String name){
    if(name == ''){
      nextButtonText = '入力せず次へ';
    }else{
      nextButtonText = '次へ';
    }
    notifyListeners();
  }

  void setTimer(value){
    timerDuration = value;
    timerSecond = timerDuration.inSeconds;

    defaultMinutes = timerSecond ~/ 60;
    defaultSeconds = timerSecond % 60;

    if(timerSecond == 0){
      minutesView = '--';
      secondsView = '--';
    }else{
      setDefaultValueToTimerView();
    }
    notifyListeners();
  }

  void changeNextButtonTextAtTimerScreen(){
    if(timerSecond == 0){
      nextButtonText = '設定せず次へ';
    }else{
      nextButtonText = '次へ';
    }
    notifyListeners();
  }

  void shufflePlayerOrder(){
    List<String> playerNameListClone = [...playerNameList];
    int index = random.nextInt(4);
    for(int i=0; i<4; i++){
      if(index >= 4){
        index = index - 4;
      }
      playerNameList[i] = playerNameListClone[index];
      index++;
    }
  }

  void rollDice(){
    diceValue1 = random.nextInt(6) + 1;
    diceValue2 = random.nextInt(6) + 1;
    diceSum = diceValue1 + diceValue2;
  }

  void cancelTimer(){
    if(isTimerRunning){
      sub.cancel();
      isTimerRunning = false;
      setDefaultValueToTimerView();
    }
  }

  void startTimer() {
    if(timerSecond > 0){
      isTimerRunning = true;
      int _remainTime = timerSecond;
      _countdownTimer = CountdownTimer(
        Duration(seconds: timerSecond),
        Duration(seconds: 1),
      );
      sub = _countdownTimer.listen(null);
      sub.onData((duration) {
        _remainTime--;
        int minutes = _remainTime ~/ 60;
        int seconds = _remainTime % 60;

        if(minutes < 10){
          minutesView = '0$minutes';
          if(seconds < 10){
            secondsView = '0$seconds';
          }else{
            secondsView = '$seconds';
          }
        }else{
          minutesView = '$minutes';
          if(seconds < 10){
            secondsView = '0$seconds';
          }else{
            secondsView = '$seconds';
          }
        }
        notifyListeners();
      });
      sub.onDone(() {
        playAlarmSound();
        sub.cancel();
        isTimerRunning = false;
        setDefaultValueToTimerView();
      });
    }
  }

  void setDefaultValueToTimerView(){
    if(defaultMinutes < 10){
      minutesView = '0$defaultMinutes';
      if(defaultSeconds < 10){
        secondsView = '0$defaultSeconds';
      }else{
        secondsView = '$defaultSeconds';
      }
    }else {
      minutesView = '$defaultMinutes';
      if (defaultSeconds < 10) {
        secondsView = '0$defaultSeconds';
      } else {
        secondsView = '$defaultSeconds';
      }
    }
  }

  void updatePlayerCount(){
    if(playerCount == playerNameList.length - 1){
      playerCount = 0;
    }else{
      playerCount++;
    }
  }

  void onPressedDiceButton(){
    rollDice();
    cancelTimer();
    startTimer();
    updatePlayerCount();
    notifyListeners();
  }

  Widget showDiceImage(int value){
    int diceValue;
    switch (value){
      case 1:
        diceValue = 1;
        break;
      case 2:
        diceValue = 2;
        break;
      case 3:
        diceValue = 3;
        break;
      case 4:
        diceValue = 4;
        break;
      case 5:
        diceValue = 5;
        break;
      case 6:
        diceValue = 6;
        break;
    }
    String diceImageUrl = 'assets/dice-$diceValue.png';
    return Container(
      height: 150,
      width: 150,
      child: Image.asset(diceImageUrl),
    );
  }

  Future<void> loadSound() async{
    final ByteData alarmAsset = await rootBundle.load('assets/alarm.mp3');
    alarmSoundId = await soundPool.load(alarmAsset);
    final ByteData diceAsset = await rootBundle.load('assets/dice_roll.mp3');
    diceSoundId = await soundPool.load(diceAsset);
  }
  Future<void> playDiceSound() async {
    var _diceSound = diceSoundId;
    diceSoundStreamId = await soundPool.play(_diceSound);
  }
  Future<void> playAlarmSound() async{
    var _alarmSound = alarmSoundId;
    alarmSoundStreamId = await soundPool.play(_alarmSound);
  }
}