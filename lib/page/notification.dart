
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging_platform_interface/src/remote_message.dart';
import 'package:flutter_local_notifications/src/flutter_local_notifications_plugin.dart';

class Notif extends StatefulWidget {
  @override
  static List<String> mac = [];
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Notif> {
  FirebaseMessaging _messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState(){
   // getToken();
    //initMessaging();
    
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text("Notification");

  }

  void getToken() {
    _messaging.getToken().then((value) {
      String? token = value;
      print(token);
    });
  }

  void initMessaging() {
    var androidInit = AndroidInitializationSettings('@mipmap/launcher');
    var iosInit = IOSInitializationSettings();
    var initSetting = InitializationSettings(android: androidInit, iOS: iosInit);
    flutterLocalNotificationPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationPlugin.initialize(initSetting);
    var androidDetails = AndroidNotificationDetails('1', 'Default',
    channelDescription: "channel Description",
    importance: Importance.high,
    priority: Priority.high);
    var iosDetails = IOSNotificationDetails();
    var generalNotificationDetails = NotificationDetails(android: androidDetails, iOS: iosDetails);
    FirebaseMessaging.onMessage.listen((RemoteMessage message){
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if(notification != null && android != null){
        flutterLocalNotificationPlugin.show(notification.hashCode, notification.title, notification.body, generalNotificationDetails);
      }
    });
  }
}