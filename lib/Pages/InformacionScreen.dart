import 'package:flutter/material.dart';
class InformacionScreen extends StatefulWidget {
  @override
  _InformacionScreenState createState() => _InformacionScreenState();
}

class _InformacionScreenState extends State<InformacionScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.only(top: 1),child: Center(child: Column(
      children: <Widget>[
        Image.network("https://scontent.faep9-1.fna.fbcdn.net/v/t1.0-9/1601417_329368603911100_2277162521567646177_n.jpg?_nc_cat=104&_nc_ht=scontent.faep9-1.fna&oh=91cac5bdc81830ce0f9063341f304a30&oe=5CE20482",filterQuality: FilterQuality.low,width: 300,height: 300,),
        Text("Iglesia Bautista Berea",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
        Text("Horario de las Reuniones:"),
        Text("Jueves 19:00 hs  Estudio Bíblico"),
        Text("Sábados 17:00 hs -> Reunión de Jóvenes"),
        Text("Domingo 10:00 hs -> Escuela Dominical"),
        Text("Domingo 11:00 hs-> Culto Dominical"),
        Text("Domingo 19:00 hs -> Estudio Bíblico"),
        Divider()

      ],
    ),),

    );
  }
}