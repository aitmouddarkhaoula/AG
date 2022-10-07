import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
//import 'package:app_settings/app_settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:wifi_scan/wifi_scan.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:wifi_info_flutter/wifi_info_flutter.dart';

/// This is the main app stateful widget.
class Wifi extends StatefulWidget {
  @override
  static List<String> mac = [];
  static List<String> ssidlist = [];
  _MyAppState createState() => _MyAppState();
}

/// This is the app state.
class _MyAppState extends State<Wifi> {
  //firebase
  late final dref=FirebaseDatabase.instance.ref().orderByKey();
  late DatabaseReference databaseReference;

  //access points
  List<WiFiAccessPoint> accessPoints = <WiFiAccessPoint>[];
  List<WiFiAccessPoint> amanGazAccessPoints = <WiFiAccessPoint>[];
  StreamSubscription<Result<List<WiFiAccessPoint>, GetScannedResultsErrors>>?
  subscription;

  //Bssid of wifi connected
  final info = NetworkInfo();

  //token
  late String token;


//Method: get access points
  void _handleScannedResults(BuildContext context,
      Result<List<WiFiAccessPoint>, GetScannedResultsErrors> result) {
    if (result.hasError) {
      kShowSnackBar(context, "Cannot get scanned results: ${result.error}");
      setState(() => accessPoints = <WiFiAccessPoint>[]);
    } else {
      amanGazAccessPoints.clear();
      setState(() => accessPoints = result.value!);
      for(final ap in accessPoints){
        if (ap.ssid.startsWith("i"))
        {
          amanGazAccessPoints.add(ap);
        }
      }
    }
  }


 /* Future<List<APClient>> getClientList(
      bool onlyReachables, int reachableTimeout) async {
    List<APClient> htResultClient;

    try {
      htResultClient = await WiFiForIoTPlugin.getClientList(
          onlyReachables, reachableTimeout);
    } on PlatformException {
      htResultClient = <APClient>[];
    }

    return htResultClient;
  }
  void showClientList() async {
    /// Refresh the list and show in console
    getClientList(false, 300).then((val) => val.forEach((oClient) {
      print("************************");
      print("Client :");
      print("ipAddr = '${oClient.ipAddr}'");
      print("hwAddr = '${oClient.hwAddr}'");
      print("device = '${oClient.device}'");
      print("isReachable = '${oClient.isReachable}'");
      print("************************");
    }));
  }*/

  // build access point tile.
   _buildAccessPointTile(BuildContext context, WiFiAccessPoint ap) {
    final Completer<WebViewController> _controller = Completer<WebViewController>();
    final title = ap.ssid.isNotEmpty ? ap.ssid : "**EMPTY**";
    final loginButton = Material(
      elevation:5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blue[900],
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          connect(ap);

        },
        child: Text(
          "Connecter",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold,
          ),

        ),
      ),
    );
    final signalIcon =
    ap.level >= -80 ? Icons.signal_wifi_4_bar : Icons.signal_wifi_0_bar;

    return ListTile(
      visualDensity: VisualDensity.compact,
      leading: Icon(signalIcon),
      title: Text(title),
      subtitle: Text(ap.bssid),
      trailing:ElevatedButton.icon(
        icon: const Icon(Icons.add),
        label: const Text('Ajouter'),
        // call getScannedResults and handle the result
        onPressed: () => showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                title: Text(title),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //width: 400,
                  //height: 400,
                  children: [
                  Container(height: 400, child:WebView(
                      initialUrl: 'http://google.com/',
                      javascriptMode: JavascriptMode.unrestricted,
                      onWebViewCreated: (WebViewController webViewController) {
                        _controller.complete(webViewController);
                      },),),
                    loginButton,


                  ],
                ),

              ),
        ),
      ),

    );
    return Text("cc");



  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FutureBuilder<bool>(
          future: WiFiScan.instance.hasCapability(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.data!) {
              return const Center(child: Text("WiFi scan not supported."));
            }
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  Flexible(
                    child: Center(
                      child: amanGazAccessPoints.isEmpty
                          ? const Text("NO SCANNED RESULTS")
                          : ListView.builder(
                          itemCount: amanGazAccessPoints.length,
                          itemBuilder: (context, i) =>

                              _buildAccessPointTile(
                                  context, amanGazAccessPoints[i])),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.refresh_rounded),
                        label: const Text('Chercher un détecteur'),
                        // call getScannedResults and handle the result
                        onPressed: () async => _handleScannedResults(context,
                            await WiFiScan.instance.getScannedResults()),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void connect(WiFiAccessPoint ap) async {
    var wifiBssid = await info.getWifiBSSID();
    var bssid = ap.bssid.toUpperCase().substring(3);
    FirebaseDatabase.instance.ref('${bssid.toString()}/${wifiBssid.toString()}').get().then((snapshot) {
      if (snapshot.exists) {
        getToken(ap);
        print('hhhhhhhhhhh');
      } else {
        print('No data available.1');
        print(bssid);
        print(wifiBssid);
      }
    });
    /*var wifiBssid = await info.getWifiBSSID();
    var bssid = ap.bssid.toUpperCase().substring(3);
    dref.onValue.listen((DatabaseEvent event) {
      String mac = event.snapshot.key.toString();
      if(mac==bssid){
        getToken(ap);
        print('yeaaaaaaaaaaah');
        print(mac);
        print(bssid);

      }
      else{
        print(mac);
      }
      }

    );*/
  }
  getToken(WiFiAccessPoint ap) async {
    token = (await FirebaseMessaging.instance.getToken())!;
    setState(() {
      token = token;
    });
    final DatabaseReference _database = FirebaseDatabase().reference();
      var Bssid = ap.bssid.toUpperCase().substring(3);
      _database.child('${Bssid.toString()}/').set({"token": token});
  }


}

/// Show snackbar.
void kShowSnackBar(BuildContext context, String message) {
  if (kDebugMode) print(message);
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));

}