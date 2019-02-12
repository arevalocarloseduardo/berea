import 'package:firebase_database/firebase_database.dart';
 
class Peticiones {
  String _id;
  String _peticion;
  String _fecha;
 
  Peticiones(this._id, this._peticion, this._fecha);
 
  Peticiones.map(dynamic obj) {
    this._id = obj['id'];
    this._peticion = obj['peticion'];
    this._fecha = obj['fecha'];
  }
 
  String get id => _id;
  String get peticion => _peticion;
  String get fecha => _fecha;
 
  Peticiones.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _peticion = snapshot.value['peticion'];
    _fecha = snapshot.value['fecha'];
  }
}