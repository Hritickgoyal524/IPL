
import 'package:flutter/material.dart';

import 'orangecap.dart';
import 'purplecap.dart';

class Stats extends StatefulWidget{
_StatsState createState()=>_StatsState();




}
class _StatsState extends State<Stats>with SingleTickerProviderStateMixin{
  TabController tabController;
    void initState(){
      tabController=TabController(length:2,vsync:this);
      super.initState();
    }
    buildtab(String title,Color color,){
      return Container(
        width:MediaQuery.of(context).size.width,
        height:40,
        decoration:BoxDecoration(
          color:color
        ),
        child:Center(child:Text(title,style:TextStyle(color:Colors.black,fontSize:20,fontWeight:FontWeight.bold)))
      );
    }
    Widget build (BuildContext context){
  return Scaffold(
appBar:AppBar(
  centerTitle:true,
  backgroundColor:Colors.white,
  title:Text("Leaders",style:TextStyle(color:Colors.black,fontSize:25)),
  bottom:TabBar(
    controller:tabController,
    tabs:[
      buildtab("Orang Cap",Colors.deepOrange),
      buildtab("Purple Cap",Colors.purple)
    ]
  ),),
  body:TabBarView(
    controller:tabController,
    children:[
      OrangeCap(),
      PurpleCap()
    ]
  )
  );
    }}