
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart'as parser;
class Pointstable extends StatefulWidget{
_PointstableState createState()=>_PointstableState();

}
class _PointstableState extends State<Pointstable>{
   List teams=[];
    List played=[];
    List wins=[];
    List losses=[];
    List points=[];
    bool dataisthere=false;
     void initState(){
      gettable();
      super.initState();
     }
       gettable()async{
String url="https://www.iplt20.com/points-table/2020";
var response=await http.get(url);
dom.Document document=parser.parse(response.body);
final teamclass=document.getElementsByClassName("standings-table__team-name standings-table__team-name--short js-team");
for(var i=0;i<teamclass.length;i++)
{
  teams.add(teamclass[i].innerHtml);
}

final playedclass=document.getElementsByClassName("standings-table__padded");
for(var i=0;i<playedclass.length;i++)
{
  played.add(playedclass[i].innerHtml);

    }

final wonlostclass=document.getElementsByClassName("standings-table__optional");
for(var i=6;i<wonlostclass.length;i=i+8){

 wins.add(wonlostclass[i].innerHtml);
    losses.add(wonlostclass[i+1].innerHtml);}
final ptsclass=document.getElementsByClassName("standings-table__highlight js-points");
for(var i=0;i<ptsclass.length;i++){
points.add(ptsclass[i].innerHtml);
}
setState((){
  dataisthere=true;
} ); 


 }
     Widget buildrow(String team,String won,String loss,String played,String pts,bool iswhite){
    return Container(
      width:MediaQuery.of(context).size.width,
      height:60,
      decoration:BoxDecoration(
        color:iswhite==true?Colors.white:Colors.grey[300]

      ),
      child:Row(
        mainAxisAlignment:MainAxisAlignment.spaceEvenly,
        children:[
          
        Text(team,style:TextStyle(color:Colors.black,fontWeight:FontWeight.w600)),
              Text(played,style:TextStyle(color:Colors.black,fontWeight:FontWeight.w600)),
              Text(won,style:TextStyle(color:Colors.black,fontWeight:FontWeight.w600)),
              Text(loss,style:TextStyle(color:Colors.black,fontWeight:FontWeight.w600)),
              Text(pts,style:TextStyle(color:Colors.black,fontWeight:FontWeight.w600)),
              
        ]));
    
    }
  Widget build(BuildContext context){
return Scaffold(
   body:dataisthere==false?Center(child:CircularProgressIndicator()):SingleChildScrollView(
      physics:ScrollPhysics(),
      child:Column(
        children:[
          Container(
            margin: EdgeInsets.only(top:50),
          width:MediaQuery.of(context).size.width,
          height:60,
          decoration:BoxDecoration(
            gradient:LinearGradient(
              colors:GradientColors.coolBlues,
              
            )
          ),
          child:Row(
            mainAxisAlignment:MainAxisAlignment.spaceEvenly,
            children:[
              Text("Team",style:TextStyle(color:Colors.white,fontWeight:FontWeight.w600)),
              Text("Pld",style:TextStyle(color:Colors.white,fontWeight:FontWeight.w600)),
              Text("Won",style:TextStyle(color:Colors.white,fontWeight:FontWeight.w600)),
              Text("Lost",style:TextStyle(color:Colors.white,fontWeight:FontWeight.w600)),
              Text("Pts",style:TextStyle(color:Colors.white,fontWeight:FontWeight.w600)),
              
              
            ]
          )
        ),
        
      buildrow(teams[0],wins[0],losses[0],played[1],points[0],false),
       buildrow(teams[1],wins[1],losses[1],played[2],points[1],true),
       buildrow(teams[2],wins[2],losses[2],played[3],points[2],false),
       buildrow(teams[3],wins[3],losses[3],played[4],points[3],true),
       buildrow(teams[4],wins[4],losses[4],played[5],points[4],false),
       buildrow(teams[5],wins[5],losses[5],played[6],points[5],true),
       buildrow(teams[6],wins[6],losses[6],played[7],points[6],false),
       buildrow(teams[7],wins[7],losses[7],played[8],points[7],true),
     ] )        
      )

  
) ; }
}