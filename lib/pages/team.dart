
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:ipl2/help.dart';

import '../viewteam.dart';

class Teams extends StatefulWidget{
_TeamsState createState()=>_TeamsState();




}
class _TeamsState extends State<Teams>{
 List<Iplteam> teams=[
      Iplteam(teamname:"Delhi Capitals",teamsc:"DC",colors:GradientColors.coolBlues,url:"delhi-capitals"),
      Iplteam(teamname:"Kolkata Knight Riders",teamsc:"KkR",colors:GradientColors.purple,url:"kolkata-knight-riders"),
      Iplteam(teamname:"Chennai Super Kings",teamsc:"CSk",colors:GradientColors.yellow,url:"chennai-super-kings"),
      Iplteam(teamname:"Royal Challengers Bangalore",teamsc:"RCB",colors:GradientColors.juicyOrange,url:"royal-challengers-bangalore"),
       Iplteam(teamname:"Sunrisers Hyderabad",teamsc:"SRH",colors:GradientColors.orange,url:"sunrisers-hyderabad"),
       Iplteam(teamname:"Mumbai Indians",teamsc:"MI",colors:GradientColors.dimBlue,url:"mumbai-indians"),
      Iplteam(teamname:"Kings XI Punjab",teamsc:"KXIP",colors:GradientColors.pink,url:"kings-xi-punjab"),
       Iplteam(teamname:"Rajasthan Royals",teamsc:"RR",colors:GradientColors.piggyPink,url:"rajasthan-royals")
    ];


  Widget build(BuildContext context){
return Scaffold(
body:GridView.count(
      crossAxisCount:2,
      crossAxisSpacing:15,
      mainAxisSpacing:15,
      children:teams.map((eachvalue){
       return InkWell(
         onTap:(){
           Navigator.push(context,MaterialPageRoute(builder:(context)=>ViewTeam(teamname:eachvalue.teamname,team_sc:eachvalue.teamsc,color:eachvalue.colors,url:eachvalue.url)));
         },
         child:
       Container(
         decoration:BoxDecoration(
           gradient:LinearGradient(colors:eachvalue.colors) ),
           child:Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly,
             children:[
               Image.asset("assets/images/${eachvalue.teamname}.png",height:120,width:117,fit:BoxFit.cover),
               Text("${eachvalue.teamsc}",style:TextStyle(color:Colors.black,fontWeight:FontWeight.w800,fontSize:25))
             ]
            
           )
       )
       );
      }).toList()
      )

) ; }
}