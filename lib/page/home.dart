import 'package:ag/page/wifi.dart';

import '../page/detecteur.dart';
import '../widget/tabbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'notification.dart';



class MyApp extends StatelessWidget {
  static final String title = 'Aman Gaz';

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,
    theme: ThemeData(primarySwatch: Colors.blueGrey),
    home: MainPage(),
  );
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) => TabBarWidget(
    title: 'Aman Gaz',
    tabs: [
      Tab(icon: Icon(Icons.add_moderator), text: 'Mes détecteurs'),
      Tab(icon: Icon(Icons.wifi_tethering_outlined), text: 'Ajouter un détécteur'),
    ],
    children: [
      EditablePage(),
      Wifi(),
    ],
  );
}
