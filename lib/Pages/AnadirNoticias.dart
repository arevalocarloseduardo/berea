import 'package:bereaapp/Data/Noticias.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

  
import 'package:path/path.dart';
class AnadirNoticias extends StatefulWidget {
  final Noticias note;
  AnadirNoticias(this.note);
  
  @override
  _AnadirNoticiasState createState() => _AnadirNoticiasState();
}
final peticionesReference = FirebaseDatabase.instance.reference().child('noticias');
 
class _AnadirNoticiasState extends State<AnadirNoticias> {
  File sampleImage;
  String filename;
  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      sampleImage = tempImage;
    });
  }
  

 //https://www.youtube.com/watch?v=xbEiBgY_BtU
  
  TextEditingController _titleController;
  TextEditingController _imageController;
  TextEditingController _descriptionController;
  TextEditingController _fechaController;
  TextEditingController _horaController;
  TextEditingController _lugarController;

  @override
  void initState() {
    super.initState();     
    _titleController = new TextEditingController(text: widget.note.title);
    _imageController = new TextEditingController(text: widget.note.imageurl);
    _descriptionController = new TextEditingController(text: widget.note.descripcion);    
    _fechaController = new TextEditingController(text: widget.note.fecha);    
    _horaController = new TextEditingController(text: widget.note.horario);    
    _lugarController = new TextEditingController(text: widget.note.lugar);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Añadir Noticias')),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                enabled: true,
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Titulo'),
              ),
                sampleImage==null? Text("selecionar imagen"):subirImagen(),
                RaisedButton(
                 color: Colors.blueAccent,
                 onPressed: (){getImage();},
                 child: Text("Cargar imagen"),),
                              RaisedButton(
                 color: Colors.blueAccent,
                 child: Text("subir Imagen"),
                 onPressed: (){
                 },
                                ),
                                Padding(padding: EdgeInsets.all(10.0)),
                                TextField(
                                 enabled: true,
                                 controller: _imageController,
                                 decoration: InputDecoration(labelText: 'URL imagen'),
                               ),
                                Padding(padding: EdgeInsets.all(10.0)),
                                TextField(
                                 enabled: true,
                                 controller: _descriptionController,
                                 decoration: InputDecoration(labelText: 'Descripción'),
                               ),
                               Padding(padding: EdgeInsets.all(10.0)),
                               TextField(
                                 controller: _fechaController,
                                 decoration: InputDecoration(labelText: 'Fecha'),
                               ),
                               Padding(padding: EdgeInsets.all(10.0)),
                               TextField(
                                 controller: _horaController,
                                 decoration: InputDecoration(labelText: 'Hora'),
                               ),
                               Padding(padding: EdgeInsets.all(10.0)),
                               TextField(
                                 controller: _lugarController,
                                 decoration: InputDecoration(labelText: 'Lugar'),
                               ),
                               Padding(padding: EdgeInsets.all(5.0)),
                               RaisedButton(
                                 child: (widget.note.id != null) ? Text('actualizar') : Text('agregar'),
                                 onPressed: () {
                                   if (widget.note.id != null) {
                                     peticionesReference.child(widget.note.id)
                                     .set({
                                       'title': _titleController.text,
                                       'imageurl': _imageController.text,
                                       'descripcion': _descriptionController.text,
                                       'fecha': _fechaController.text,
                                       'horario': _horaController.text,
                                       'lugar': _lugarController.text,
                                     }).then((_) {
                                       Navigator.pop(context);
                                     });
                                   } else {
                                     peticionesReference.push()
                                     .set({
                                       'title': _titleController.text,
                                       'imageurl': _imageController.text,
                                       'descripcion': _descriptionController.text,
                                       'fecha': _fechaController.text,
                                       'horario': _horaController.text,
                                       'lugar': _lugarController.text,
                                     }).then((_) {
                                       Navigator.pop(context);
                                     });
                                   }
                                 },
                               ),
                             ],
                           ),
                         ),
                       ),
                     );
                   }

  Widget subirImagen() {
    return Container(
      child: Column(
        children: <Widget>[
          Image.file(sampleImage,height: 100,width: 100,),
          RaisedButton(
            child: Text("enviar"),
            onPressed: (){
              final StorageReference firebaseReference = FirebaseStorage.instance.ref().child("imagenes.jpg");
              final StorageUploadTask task = firebaseReference.putFile(sampleImage);
            },
            )
        ],
      ),
    );
  }
                 
                  
}