/*import 'dart:ui';

//import 'package:app_settings/app_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/detecteur.dart';
import '../widget/scrollable_widget.dart';
import '../widget/text_dialog_widget.dart';
import '../utils.dart';
import '../page/wifi.dart';

class EditablePage extends StatefulWidget {
  @override
  _EditablePageState createState() => _EditablePageState();
}

class _EditablePageState extends State<EditablePage> {
 // late List<Detecteur> detecteur;
  bool _isEnabled = false;
  late final dref=FirebaseDatabase.instance.reference();
  late DatabaseReference databaseReference;


  var n =Wifi.mac.toSet().toList();
  List detectors=[];
  /*CollectionReference detectorsref = FirebaseFirestore.instance.collection("detectors");
  getData() async {
    var responsebody = await detectorsref.where("BSSDI", whereIn: n).snapshots();
    responsebody.listen((event) {
      event.docs.forEach((element) {
    setState(() {
    detectors.add(element.data());
    });
    }); });
  }*/

  @override
  void initState() {
      //getData();
    super.initState();
    //getToken();
    databaseReference=dref;
   //_activateListeners();

    //this.detecteur = List.of(allDetecteur);
  }
 /* void _activateListeners() {
    dref.onValue.listen((DatabaseEvent event) {
      String mac = event.snapshot.key.toString();
      dynamic alert = event.snapshot.child("alert").value.toString();

      setState(() {
        print("hello");
        print(alert.runtimeType);
        print(alert);
        print(mac);
        detectors.add(mac);
      });}

    );
}*/
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
          FirebaseAnimatedList(
            shrinkWrap: true,
            query: databaseReference,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation animation, int index){
                return ListTile(
                  visualDensity: VisualDensity.compact,
                  leading: Icon(snapshot.child("alert").value.toString() == "0" ? Icons.check_circle_rounded :
                  Icons.error,
                      color: snapshot.child("alert").value.toString() == "0" ? Colors.green: Colors.red),
                  tileColor: snapshot.child("alert").value.toString() != "0" ? Colors.redAccent.shade100 : null,
                  title: TextField(enabled: _isEnabled, decoration: InputDecoration(
                    hintText: "Detecteur ${index}",
                  ),),
                  subtitle: n.contains(snapshot.key.toString())? Text(  "${snapshot.key.toString()}${snapshot.child("alert").value.toString()}"):null,
                  trailing: GestureDetector(
                    child: new Icon(
                      Icons.edit,
                      color: Colors.blue,
                    ),
                    onTap: () {
                      setState((){
                        _isEnabled = !_isEnabled;
                      });
                    },
                  ),
                );
            }
            )
        ],
      ),
    );
  }





/* @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: ListView.builder(
        itemCount: detectors.length,
        itemBuilder: (BuildContext context, int i){
          return ListTile(
            title: Text("Detecteur ${i} "),
              subtitle: Text(detectors[i]),
          );
    },


      ),
    );
  }*/

 /* @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(


      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:[
          Expanded(child:ScrollableWidget(child: buildDataTable()),),

        ]


      )
    ),
    floatingActionButton: new FloatingActionButton(
      onPressed: () {
        AppSettings.openWIFISettings();
      },
      child: new Icon(Icons.add),
    ),
  );

  Widget buildDataTable() {
    final columns = ['Name', 'ID', 'IP'];

    return DataTable(
      columns: getColumns(columns),
      rows: getRows(detecteur),
    );
  }

  List<DataColumn> getColumns(List<String> columns) {
    return columns.map((String column) {

      return DataColumn(
        label: Text(column, style: TextStyle(fontSize: 15, color: Colors.blue[500],)),
      );
    }).toList();
  }

  List<DataRow> getRows(List<Detecteur> users) => users.map((Detecteur detecteur) {
    final cells = [detecteur.name, detecteur.id, detecteur.ip];

    return DataRow(
      cells: Utils.modelBuilder(cells, (index, cell) {
        final showEditIcon = index == 0;
        final value= cells;

        return DataCell(
          Text('$cell', style: TextStyle(fontSize: 10, color: Colors.grey[500],)),
          showEditIcon: showEditIcon,
          onTap: () {
                editFirstName(detecteur);

                },
        );
      }),
    );
  }).toList();

  Future editFirstName(Detecteur editDetecteur) async {
    final name = await showTextDialog(
      context,
      title: 'Change name',
      value: editDetecteur.name,
    );

    setState(() => detecteur = detecteur.map((detecteur) {
      final isEditedDetecteur = detecteur == editDetecteur;

      return isEditedDetecteur ? detecteur.copy(name: name) : detecteur;
    }).toList());
  }*/


}*/
import 'dart:ui';
//import 'package:app_settings/app_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/detecteur.dart';
import '../widget/scrollable_widget.dart';
import '../widget/text_dialog_widget.dart';
import '../utils.dart';
import '../page/wifi.dart';

class EditablePage extends StatefulWidget {
  @override
  _EditablePageState createState() => _EditablePageState();
}

class _EditablePageState extends State<EditablePage> {
 // late List<Detecteur> detecteur;
  bool _isEnabled = false;
  late final dref=FirebaseDatabase.instance.reference();
  late DatabaseReference databaseReference;

  var n =Wifi.mac.toSet().toList();
  List detectors=[];
  /*CollectionReference detectorsref = FirebaseFirestore.instance.collection("detectors");
  getData() async {
    var responsebody = await detectorsref.where("BSSDI", whereIn: n).snapshots();
    responsebody.listen((event) {
      event.docs.forEach((element) {
    setState(() {
    detectors.add(element.data());
    });
    }); });
  }*/

  @override
  void initState() {
      //getData();
    super.initState();
    //getToken();
    databaseReference=dref;
   //_activateListeners();

    //this.detecteur = List.of(allDetecteur);
  }
 /* void _activateListeners() {
    dref.onValue.listen((DatabaseEvent event) {
      String mac = event.snapshot.key.toString();
      dynamic alert = event.snapshot.child("alert").value.toString();

      setState(() {
        print("hello");
        print(alert.runtimeType);
        print(alert);
        print(mac);
        detectors.add(mac);
      });}

    );
}*/
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
          FirebaseAnimatedList(
            shrinkWrap: true,
            query: databaseReference,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation animation, int index){
                return ListTile(
                  visualDensity: VisualDensity.compact,
                  leading: Icon(snapshot.child("alert").value.toString() == "0" ? Icons.check_circle_rounded :
                  Icons.error,
                      color: snapshot.child("alert").value.toString() == "0" ? Colors.green: Colors.red),
                  tileColor: snapshot.child("alert").value.toString() != "0" ? Colors.redAccent.shade100 : null,
                  title: TextField(enabled: _isEnabled, decoration: InputDecoration(
                    hintText: "Detecteur ${index}",
                  ),),
                  subtitle: n.contains(snapshot.key.toString())? Text(  "${snapshot.key.toString()}${snapshot.child("alert").value.toString()}"):null,
                  trailing: GestureDetector(
                    child: new Icon(
                      Icons.edit,
                      color: Colors.blue,
                    ),
                    onTap: () {
                      setState((){
                        _isEnabled = !_isEnabled;
                      });
                    },
                  ),
                );
            }
            )
        ],
      ),
    );
  }





/* @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: ListView.builder(
        itemCount: detectors.length,
        itemBuilder: (BuildContext context, int i){
          return ListTile(
            title: Text("Detecteur ${i} "),
              subtitle: Text(detectors[i]),
          );
    },


      ),
    );
  }*/

 /* @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(


      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:[
          Expanded(child:ScrollableWidget(child: buildDataTable()),),

        ]


      )
    ),
    floatingActionButton: new FloatingActionButton(
      onPressed: () {
        AppSettings.openWIFISettings();
      },
      child: new Icon(Icons.add),
    ),
  );

  Widget buildDataTable() {
    final columns = ['Name', 'ID', 'IP'];

    return DataTable(
      columns: getColumns(columns),
      rows: getRows(detecteur),
    );
  }

  List<DataColumn> getColumns(List<String> columns) {
    return columns.map((String column) {

      return DataColumn(
        label: Text(column, style: TextStyle(fontSize: 15, color: Colors.blue[500],)),
      );
    }).toList();
  }

  List<DataRow> getRows(List<Detecteur> users) => users.map((Detecteur detecteur) {
    final cells = [detecteur.name, detecteur.id, detecteur.ip];

    return DataRow(
      cells: Utils.modelBuilder(cells, (index, cell) {
        final showEditIcon = index == 0;
        final value= cells;

        return DataCell(
          Text('$cell', style: TextStyle(fontSize: 10, color: Colors.grey[500],)),
          showEditIcon: showEditIcon,
          onTap: () {
                editFirstName(detecteur);

                },
        );
      }),
    );
  }).toList();

  Future editFirstName(Detecteur editDetecteur) async {
    final name = await showTextDialog(
      context,
      title: 'Change name',
      value: editDetecteur.name,
    );

    setState(() => detecteur = detecteur.map((detecteur) {
      final isEditedDetecteur = detecteur == editDetecteur;

      return isEditedDetecteur ? detecteur.copy(name: name) : detecteur;
    }).toList());
  }*/


}
