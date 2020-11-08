import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart'as parser;
class OrangeCap extends StatefulWidget{
  _OrangeCapState createState()=>_OrangeCapState();

}
class _OrangeCapState extends State<OrangeCap>{
 List runs=[];
  List player=[];
  bool dataisshare=false;
  getStats()async {
String url="https://www.iplt20.com/stats/2020/most-runs";
var response=await http.get(url);
dom.Document document=parser.parse(response.body);
print("response");
print(response.statusCode);
print(document);
final playername=document.getElementsByClassName("top-players__last-name");
for(var i=0;i<playername.length;i++){
player.add(playername[i].innerHtml);
}

final playerrun=document.getElementsByClassName("top-players__r  is-active");
print(player.length);
for(var i=0;i<playerrun.length;i++){
runs.add(playerrun[i].innerHtml);
}
setState((){
  dataisshare=true;
  print("paleyer/n");
  print(runs);
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