import 'package:bereaapp/Data/Peticiones.dart';
import 'package:bereaapp/Pages/AnadirCumples.dart';
import 'package:bereaapp/Pages/AnadirPeticiones.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

class CumplesScreen extends StatefulWidget {
  @override
  _CumplesScreenState createState() => _CumplesScreenState();
}

final notesReference = FirebaseDatabase.instance.reference().child('cumples');

class _CumplesScreenState extends State<CumplesScreen> {
  List<Peticiones> turnos;
  StreamSubscription<Event> _onTurnosAddedSubscription;
  StreamSubscription<Event> _onTurnosChangedSubscription;
  StreamSubscription<Event> _onSubAddedSubscription;
  StreamSubscription<Event> _onSubChangedSubscription;

  @override
  void initState() {
    super.initState();

    turnos = new List();
    _onTurnosAddedSubscription =
        notesReference.onChildAdded.listen(_onTurnosAdded);
    _onTurnosChangedSubscription =
        notesReference.onChildChanged.listen(_onTurnosUpdated);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Berea",
      home: Scaffold(
       /*   floatingActionButton: FloatingActionButton(onPressed: (){Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AnadirCumples(Peticiones(null, "", ""))),
    );},child: Icon(Icons.cake),),     */     
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 250,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text("Cumpleaños",style:TextStyle(color:Colors.black54)),
                  background: Image.network(
                    "http://static.t13.cl/images/sizes/1200x675/1535146937-torta-cumpleaos-istock.jpg",
                    filterQuality: FilterQuality.low,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverFillViewport(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Column(
                    children: creartext(),
                  );
                }, childCount: 1),
              ),
            ],
          ),
          ),
    );
  }

  List<Column> creartext() {
    List<Column> childrenText = List<Column>();

    for (var name in turnos) {
      childrenText.add(
        new Column(
          children: <Widget>[
            ListTile(
                leading: Container(
                  child: Icon(Icons.cake, color: Colors.lightBlue),
                ),
                title: Text(
                  name.peticion,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                /*subtitle: Text(
                  "${name.fecha}",
                  style: TextStyle(color: Colors.black),
                ),
               */ trailing: Text("Fecha:${name.fecha}"),
                onTap: () => {}),
         Divider(color: Colors.blue,)],

        ),
      );
    }
    return childrenText;
  }

  void _onTurnosAdded(Event event) {
    setState(
      () {
        turnos.add(new Peticiones.fromSnapshot(event.snapshot));
      },
    );
  }

  void _onTurnosUpdated(Event event) {
    var oldNoteValue =
        turnos.singleWhere((note) => note.id == event.snapshot.key);
    setState(
      () {
        turnos[turnos.indexOf(oldNoteValue)] =
            new Peticiones.fromSnapshot(event.snapshot);
      },
    );
  }
}
