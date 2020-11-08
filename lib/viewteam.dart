import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart'as parser;

import 'help.dart';
class ViewTeam extends StatefulWidget{
  final String teamname;
  final String team_sc;
  final List<Color>color;
  final String url;
  ViewTeam({this.teamname,this.team_sc,this.color,this.url});
_ViewTeamState createState()=>_ViewTeamState();
}
class _ViewTeamState extends State<ViewTeam>
{
  List iplmatchs=[];
  List matchnumber=[];
  List matchdate=[];
  bool dataisshare=false;
  bool empty=false;
  void initState(){
    getteamschedule();
    super.initState();
  }

  getteamschedule()async{
 String url="https://www.iplt20.com/teams/${widget.url}/schedule/";
var response=await http.get(url);
print(response.statusCode);
dom.Document document=parser.parse(response.body);
var name=document.getElementsByClassName("fixture__team-name");
//print(name[2].innerHtml);
var match=document.getElementsByClassName("fixture__description");
print("match");
print(match.length);
//print(match[3].innerHtml);
var dateclass=document.getElementsByClassName("match-list__date js-date");
print("Date");
print(dateclass.length);
for(var i=0;i<name.length;i=i+4){
  for(var j=0;j<name.length;j=j+4){
   if(i==j){
 Iplmatche ipl=Iplmatche(firstteam:name[i].innerHtml,firstsc: name[i+1].innerHtml,secondteam: name[i+2].innerHtml,secondsc: name[i+3].innerHtml);
 iplmatchs.add(ipl);
 //print(iplmatchs[i]);
}
}
}
print("venue");
print(name.length);
for(var i=0;i<match.length;i++){
  print("jsnvjbnsfjbnsjfn");
  matchnumber.add(match[i].innerHtml);
}
for(var i=0;i<dateclass.length;i++){
  matchdate.add(dateclass[i].innerHtml);
}
  setState(() {
    if(iplmatchs.length==0){
      empty=true;
    }
    print("iplsmatcgs");
    print(iplmatchs);
    print("Matches");
    print(matchdate);
    dataisshare=true;
  });
  }
  Widget build (BuildContext context ){
    return Scaffold(
body:SingleChildScrollView(
        physics:ScrollPhysics(),
        child:Column(
         children:[Container(
           width:MediaQuery.of(context).size.width,
           height:MediaQuery.of(context).size.height/2.8,
           decoration:BoxDecoration(
             gradient:LinearGradient( colors:widget.color
             ),),
             child:Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children:[
                 Image.asset("assets/images/${widget.teamname}.png",height:215,width:200,fit:BoxFit.cover),
                 Text("${widget.team_sc}",style:TextStyle(fontSize:35,fontWeight:FontWeight.w900,color:Colors.black))
               ]
               
               
             )
           ),
           dataisshare==false?CircularProgressIndicator():empty?Container(child:Text("Sorry No Information Available",style:TextStyle(fontSize: 30,fontWeight: FontWeight.w700),textAlign:TextAlign.center)):
           ListView.builder(
             physics: NeverScrollableScrollPhysics(),
             shrinkWrap:true,
             itemCount:iplmatchs.length,
             itemBuilder:(context, index){
               return Container(
                 width:MediaQuery.of(context).size.width,
                 height:100,
                 
                 child:Card(
                   color:Colors.white,
                 child:Row(
                   mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                   children:[
                   Container(
                     width:MediaQuery.of(context).size.width*0.5,
                     child:
                   Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                     children:[
                   Image.asset("assets/images/${iplmatchs[index].secondteam}.png",height:80,width:70,fit:BoxFit.cover),
                   Text("VS",style:TextStyle(color:Colors.black,fontSize:20)),
                    Image.asset("assets/images/${iplmatchs[index].firstteam}.png",height:80,width:65,fit:BoxFit.cover)
                    ] )),
                    Container(
                    width:MediaQuery.of(context).size.width*.45,
                    child:
                      Column(
                     mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                     children:[
                       Text(matchdate[index],style:TextStyle(color:Colors.purple,fontSize:15,fontWeight:FontWeight.w700)),
                       Text(matchnumber[index],style:TextStyle(color:Colors.black,fontSize:16,fontWeight:FontWeight.w800,))
                     ]
                      )
                    
                    )
                    
                    ]
               )
               ));
             }
           )
         ]
        )
      )


    );

  }
}