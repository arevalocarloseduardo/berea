import 'dart:async';
import 'package:bereaapp/Data/Noticias.dart';
import 'package:bereaapp/Data/Peticiones.dart';
import 'package:bereaapp/Pages/AnadirNoticias.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class NoticiasScreen extends StatefulWidget {
  @override
  _NoticiasScreenState createState() => _NoticiasScreenState();
}
final noticiasReference =
    FirebaseDatabase.instance.reference().child('noticias');
    final utilsReference =
    FirebaseDatabase.instance.reference().child('util');



class _NoticiasScreenState extends State<NoticiasScreen> {
  
  List<Noticias> items;
  List<Noticias> util;
  String texto;
   StreamSubscription<Event> _onNoteAddedSubscription;
   
   StreamSubscription<Event> _onUtilAddedSubscription;
  StreamSubscription<Event> _onNoteChangedSubscription;
 @override
  void initState() {
    super.initState();
    

    items = new List();
    
    util = new List();
    _onUtilAddedSubscription =
        utilsReference.onChildAdded.listen(_onUtilAdded);
    _onNoteAddedSubscription =
        noticiasReference.onChildAdded.listen(_onNoteAdded);
    _onNoteChangedSubscription =
        noticiasReference.onChildChanged.listen(_onNoteUpdated);

    }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "meses",
      home:Scaffold(
        appBar: AppBar(
           backgroundColor: Colors.blue[300],
          centerTitle: true,
          
          title: Text("$texto"),
        ),
        /*floatingActionButton: FloatingActionButton(onPressed: (){Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AnadirNoticias(Noticias(null,"","","","","",""))),
    );},child: Icon(Icons.call_made),)

       , */body: Container(          
          color: Colors.white,
          alignment: Alignment.topCenter,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context,index){
              return Padding(
                padding: EdgeInsets.all(10),
                child: Container(                  
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    elevation: 5,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                                               
                        Text("${items[index].title}",style: TextStyle(color:Colors.black54,fontSize: 24,fontWeight: FontWeight.bold,decoration: TextDecoration.underline)),
                        
                        Divider(),
                        Container(
                          padding: EdgeInsets.only(top: 5),         
                          child: Align(
                            alignment: Alignment(0, 0),
                            child: Image.network("${items[index].imageurl}",
                            fit: BoxFit.contain,
                            filterQuality: FilterQuality.low,),
                          ),
                        ),
                        Container(padding:EdgeInsets.all(12),child: Text("${items[index].descripcion}",textAlign: TextAlign.justify,style: TextStyle(color:Colors.black54,fontSize: 15,fontWeight: FontWeight.bold,))),
                        
                        Row(crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[Expanded(
                          child: Column(children: <Widget>[Icon(Icons.calendar_today),
                          Container(child: Text("${items[index].fecha}"),
                          ),
                          
                          ],),
                        ),
                        Expanded(
                          child: Column(children: <Widget>[Icon(Icons.access_time),
                          Container(child: Text("${items[index].horario}"),
                          ),
                          
                          ],),
                        ),
                        Expanded(
                          child: Column(children: <Widget>[Icon(Icons.place,color: Colors.black54,),
                          Container(child: Text("${items[index].lugar}",textAlign: TextAlign.center,),
                          ),
                          
                          ],),
                        ),
                        ],),Divider(color: Colors.white,)
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      )
      
    );
  }
void _onNoteAdded(Event event) {
  
       
    setState(() {
      items.add(new Noticias.fromSnapshot(event.snapshot));
    });
  }
  void _onUtilAdded(Event event) {
    setState(() {
      
      util.add(new Noticias.fromSnapshot(event.snapshot));
      texto=util.first.title; 
    });
  }

  void _onNoteUpdated(Event event) {
    var oldNoteValue =
        items.singleWhere((note) => note.id == event.snapshot.key);
    setState(
      () {
        items[items.indexOf(oldNoteValue)] =
            new Noticias.fromSnapshot(event.snapshot);
      },
    );
  }
}