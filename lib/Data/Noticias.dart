import 'package:firebase_database/firebase_database.dart';
 
class Noticias {
  String _id;
  String _title;
  String _imageurl;
  String _descripcion;
  String _fecha;
  String _horario;
  String _lugar;
  Noticias(this._id, this._title, this._imageurl,this._fecha,this._horario,this._lugar,this._descripcion);
 
  Noticias.map(dynamic obj) {
    this._id = obj['id'];
    this._title = obj['title'];
    this._imageurl = obj['imageurl'];
    this._descripcion = obj['descripcion'];
    this._fecha = obj['fecha'];
    this._horario = obj['horario'];
    this._lugar = obj['lugar'];
  }
 
  String get id => _id;
  String get title => _title;
  String get imageurl => _imageurl;
  String get descripcion => _descripcion;
  String get fecha => _fecha;
  String get horario => _horario;
  
  String get lugar => _lugar;
 
  Noticias.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _title = snapshot.value['title'];
    _imageurl = snapshot.value['imageurl'];
    _descripcion = snapshot.value['descripcion'];
    _fecha = snapshot.value['fecha'];    
    _horario = snapshot.value['horario'];
    _lugar = snapshot.value['lugar'];
  }
}