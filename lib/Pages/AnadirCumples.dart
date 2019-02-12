import 'package:bereaapp/Data/Peticiones.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AnadirCumples extends StatefulWidget {
  final Peticiones note;
  AnadirCumples(this.note);
  @override
  _AnadirCumplesState createState() => _AnadirCumplesState();
}
final peticionesReference = FirebaseDatabase.instance.reference().child('cumples');
 
class _AnadirCumplesState extends State<AnadirCumples> {
  
  TextEditingController _titleController;
  TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();     
    _titleController = new TextEditingController(text: widget.note.fecha);
    _descriptionController = new TextEditingController(text: widget.note.peticion);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cumpleaños')),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            TextField(
              enabled: true,
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Fecha de nacimiento'),
            ),
            Padding(padding: EdgeInsets.all(5.0)),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            Padding(padding: EdgeInsets.all(5.0)),
            RaisedButton(
              child: (widget.note.id != null) ? Text('actualizar') : Text('agregar'),
              onPressed: () {
                if (widget.note.id != null) {
                  peticionesReference.child(widget.note.id)
                  .set({
                    'fecha': _titleController.text,
                    'peticion': _descriptionController.text
                  }).then((_) {
                    Navigator.pop(context);
                  });
                } else {
                  peticionesReference.push()
                  .set({
                    'fecha': _titleController.text,
                    'peticion': _descriptionController.text
                  }).then((_) {
                    Navigator.pop(context);
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}