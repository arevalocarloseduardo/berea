import 'package:bereaapp/Data/Peticiones.dart';
import 'package:bereaapp/Pages/AnadirPeticiones.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';


class PeticionesScreen extends StatefulWidget {
  @override
  _PeticionesScreenState createState() => _PeticionesScreenState();
}

final notesReference = FirebaseDatabase.instance.reference().child('peticiones');


class _PeticionesScreenState extends State<PeticionesScreen> {
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
       /*floatingActionButton: FloatingActionButton(onPressed: (){Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AnadirPeticiones(Peticiones(null, "", ""))),
    );
    },child: Icon(Icons.add),),
    */
    
        body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 250,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text("Peticiones",style:TextStyle(color: Colors.black54)),
                  background: Image.network(
                    "https://thumbs.dreamstime.com/thumb_496/4961730.jpg",
                    filterQuality: FilterQuality.low,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverFillViewport(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return SingleChildScrollView(
                    child: Column(
                      children: creartext(),
                    ),
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
                      child: Icon(Icons.mode_comment, color: Colors.black38),
                    ),
                    title: Text(
                      "${name.fecha}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    subtitle: Text(
                      "${name.peticion}",
                      style: TextStyle(color: Colors.black),
                    ),
                    
                    onTap: () => {}),
                    Divider()    
            ],
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