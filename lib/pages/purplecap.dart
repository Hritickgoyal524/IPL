import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart'as parser;
class PurpleCap extends StatefulWidget{
  _PurpleCapState createState()=>_PurpleCapState();

}
class _PurpleCapState extends State<PurpleCap>{
 List runs=[];
  List player=[];
  bool dataisshare=false;
  getStats()async {
String url="https://www.iplt20.com/stats/2020/most-wickets";
var response=await http.get(url);
dom.Document document=parser.parse(response.body);
final playername=document.getElementsByClassName("top-players__last-name");
for(var i=0;i<playername.length;i++){
player.add(playername[i].innerHtml);
}

final playerrun=document.getElementsByClassName("top-players__w  is-active");
for(var i=0;i<playerrun.length;i++){
runs.add(playerrun[i].innerHtml);
}
setState((){
  dataisshare=true;
});}
  void initState(){
    getStats();
    super.initState();
  }
 
  Widget build (BuildContext context ){
    return Scaffold(
       body:dataisshare==false?Center(child:CircularProgressIndicator()):
       ListView.builder(
         itemCount:player.length,
         itemBuilder:(context,index){
         return Card(
           child:ListTile(
             title:Text(player[index],style:TextStyle(color:Colors.orange,fontSize:25)),
             trailing:Text(runs[index],style:TextStyle(color:Colors.black,fontSize:20,fontWeight:FontWeight.bold))
           )
         );
         }
       )
    );
  }
}
