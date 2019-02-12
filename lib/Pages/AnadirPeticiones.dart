import 'package:bereaapp/Data/Peticiones.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AnadirPeticiones extends StatefulWidget {
  final Peticiones note;
  AnadirPeticiones(this.note);
  @override
  _AnadirPeticionesState createState() => _AnadirPeticionesState();
}
final peticionesReference = FirebaseDatabase.instance.reference().child('peticiones');
 
class _AnadirPeticionesState extends State<AnadirPeticiones> {
  
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
      appBar: AppBar(title: Text('Peticiones')),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            TextField(
              enabled: true,
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Titulo'),
            ),
            Padding(padding: EdgeInsets.all(5.0)),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Peticion'),
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