import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:ipl2/pages/matches.dart';
import 'package:ipl2/pages/pointtable.dart';
import 'package:ipl2/pages/stats.dart';
import 'package:ipl2/pages/team.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      home: NavigatePage(),
    );
  }
}
class NavigatePage extends StatefulWidget{
  _NavigatePageState createState()=>_NavigatePageState();
}

class _NavigatePageState extends State<NavigatePage>{
  List<Widget> pageoption=[
    Matches(),
    Teams(),
    Pointstable(),
    Stats()
    
  ];
  int page=0;
  Widget build(BuildContext context){
    return Scaffold(
      body:pageoption[page],
      bottomNavigationBar: CurvedNavigationBar(
        
        onTap: (index){
          setState(() {
            page=index;
          });
        },
        height: 50,
        backgroundColor: Colors.white,
        items: [
        Icon(Icons.home,size:32,color:Colors.black),
        Icon(Icons.person,size:32,color:Colors.black),
        Icon(Icons.table_chart,size:32,color:Colors.black),
        Icon(Icons.trending_up,size:32,color:Colors.black),
        
      ],),
    );
  }
}