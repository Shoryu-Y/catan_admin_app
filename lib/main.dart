import 'package:flutter/material.dart';
import 'package:catanadminapp/setting_player_screen_view.dart';
import 'package:catanadminapp/duel_state.dart';
import 'package:provider/provider.dart';
import 'package:soundpool/soundpool.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DuelStateModel(),
        ),
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Provider.of<DuelStateModel>(context, listen: false).loadSound();
  }
  @override
  Widget build(BuildContext context) {
    Provider.of<DuelStateModel>(context, listen: false).soundPool = Soundpool(streamType: StreamType.notification);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Catan Admin App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SafeArea(
        child: Scaffold(
          body: SettingPlayerScreenPage(),
        ),
      ),
    );
  }
}
