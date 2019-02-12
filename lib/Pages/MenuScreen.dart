import 'package:bereaapp/Pages/CumplesScreen.dart';
import 'package:bereaapp/Pages/InformacionScreen.dart';
import 'package:bereaapp/Pages/NoticiasScreen.dart';
import 'package:bereaapp/Pages/PeticionesScreen.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  int i;
  MenuScreen(this.i);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  int currentTab = 0;
  NoticiasScreen one;
  PeticionesScreen two;
  CumplesScreen tree;
  InformacionScreen four;

  List<Widget>pages;
  Widget currentPage;


  @override
  void initState() {
    one = NoticiasScreen();
    two = PeticionesScreen();
    tree =CumplesScreen();
    four = InformacionScreen();

    pages =[one,two,tree,four];
    currentTab = widget.i;
    currentPage=pages[widget.i];
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: currentPage,  
      bottomNavigationBar: BottomNavigationBar(
        
        type: BottomNavigationBarType.fixed,
        currentIndex: currentTab,
        onTap: (int index){
          setState(() {
           currentTab = index;
           currentPage = pages[index];
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            
            icon: Icon(Icons.home),
            title: Text("Boletin")
            ),
              BottomNavigationBarItem(
              icon: Icon(Icons.receipt),
              title: Text("Peticiones")
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text("Cumpleaños")
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            title: Text("Información")
            ),
        ],
      ),
    );
  }
}