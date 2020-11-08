
import 'package:flutter/material.dart';
//import 'package:CricketApp/help.dart';
import 'package:carousel_slider/carousel_slider.dart';
//import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart'as parser;
import 'package:ipl2/help.dart';

class Matches extends StatefulWidget{
_MatchesState createState()=>_MatchesState();

}
class _MatchesState extends State<Matches>{
   List iplmatchs=[];
    List matchnumber=[];
    List matchvenue=[];
    String matche="NextMatch";
  bool dataisshare=false;
void initState(){
      super.initState();
      
      getupcomingmatches();
    }



String getonlystring(index){
 bool y=matchvenue[index].startsWith("n>");
 if(y){
   String result =matchvenue[index].replaceAll("n>", " ");
   return result;
 }
 bool b=matchvenue[index].startsWith(">");
 if(b){
 String result =matchvenue[index].replaceAll(">", " ");
  return result;
 }
 return matchvenue[index];
}
getupcomingmatches()async {
  String url="https://www.iplt20.com/matches/schedule/men";
var response=await http.get(url);
dom.Document document=parser.parse(response.body);

var name=document.getElementsByClassName("fixture__team-name");
print(name[2].innerHtml);
var match=document.getElementsByClassName("fixture__description");

var venue=document.getElementsByClassName("fixture__info");
for(var i=0;i<name.length;i++){
  
  for(var j=0;j<name.length;j=j+4){
   
  if(i==j){
 Iplmatche ipl=Iplmatche(firstteam:name[i].innerHtml,firstsc: name[i+1].innerHtml,secondteam: name[i+2].innerHtml,secondsc: name[i+3].innerHtml);
 
 iplmatchs.add(ipl);
 
 //print(iplmatchs[i]);
}}}

for(var i=0;i<match.length;i++){
  
  matchnumber.add(match[i].innerHtml);
}
for(var i=0;i<venue.length;i++){
  print("moti");
  if(venue[i].getElementsByTagName("span")[0].innerHtml == "Live"){
  
  matchvenue.add("Live Now");
}
else{
  //print(venue[i].getElementsByTagName("span")[0].innerHtml.substring(51).trim());
  matchvenue.add(venue[i].getElementsByTagName("span")[0].innerHtml.substring(51).trim());
}
}
for(var i=0;i<matchvenue.length;i++){
  if(venue[i].getElementsByTagName("span")[0].innerHtml == "Live"){
  
  matchvenue.removeAt(0);
  matchnumber.removeAt(0);
  iplmatchs.removeAt(0);
}
}

setState(() {
 
    dataisshare=true;
  });    
}
 getnextmatch()async{
List infos=[];
String url="https://www.iplt20.com/matches/schedule/men";
var response=await http.get(url);

dom.Document document=parser.parse(response.body);
var name=document.getElementsByClassName("fixture__team-name");
//print(name[2].innerHtml);
var match=document.getElementsByClassName("fixture__description");
//print(match[3].innerHtml);
var venue=document.getElementsByClassName("fixture__info");
//print(venue[0].getElementsByTagName("span")[0].innerHtml.substring(50).trim());
//print(venue[0].getElementsByTagName("span")[0].innerHtml.substring(49).trim());
infos.add(name[0].innerHtml);
infos.add(name[1].innerHtml);
infos.add(name[2].innerHtml);
infos.add(name[3].innerHtml);

infos.add(match[0].innerHtml);
if(venue[0].getElementsByTagName("span")[0].innerHtml == "Live"){
  setState(() {
    matche="Live Match";
  });
  infos.add("Live Now");
}
else{
  infos.add(venue[0].getElementsByTagName("span")[0].innerHtml.substring(50).trim());
}

    return infos;}

String getstr(int index){

if(iplmatchs[index].firstsc=="TBC"){
   return "NTA";
}
else {
  return iplmatchs[index].firstsc;
}
}

String getimage(int index){

if(iplmatchs[index].firstteam=="TBC"){
   return "assets/images/Rest.jpg";
}
else {
  return "assets/images/"+iplmatchs[index].firstteam+".png";

}

}
String getimage1(int index){

if(iplmatchs[index].secondteam=="TBC"){
   return "assets/images/Rest1.png";
}
else {
  return "assets/images/"+iplmatchs[index].secondteam+".png";

}
}

String getstr1(int index){

if(iplmatchs[index].secondsc=="TBC"){
   return "NTA";
}
else {
  return iplmatchs[index].secondsc;
}

}
 Widget build(BuildContext context){
return Scaffold(
   backgroundColor: Colors.brown[400],
    body: SingleChildScrollView(
      physics: ScrollPhysics(),
          child:Stack(
   children: <Widget>[
     Container(
       width: MediaQuery.of(context).size.width,
       height: MediaQuery.of(context).size.height/3.5,
       decoration: BoxDecoration(
         color: Colors.pink,
       ),
       
     ),
     Container(
    child:Column(
    children: <Widget>[
    Container(
      alignment: Alignment.center,
      //color: Colors.blue,
      margin: EdgeInsets.symmetric(vertical:16),
      padding: EdgeInsets.symmetric(horizontal:10,vertical:20),
      child:
    Text("Indian Premier League App",style:GoogleFonts.montserrat(
    fontWeight: FontWeight.w800,fontSize: 23,color: Colors.black87
    ))
    ),
    //SizedBox(height: 2,),
    Container(
     // color: Colors.blueAccent,
      padding: EdgeInsets.symmetric(vertical:6,horizontal: 10)  ,
      alignment: Alignment.centerLeft,
      child:Text(matche,style:GoogleFonts.montserrat(
      fontWeight: FontWeight.w700,fontSize: 20,color: Colors.black
    )),),
    SizedBox(height: 16,),
    Container(
      margin: EdgeInsets.only(left:20,right: 30),
      height: 236,width:  MediaQuery.of(context).size.width,
    decoration: BoxDecoration(color:Colors.grey[600]),
      child:FutureBuilder(
        future: getnextmatch(),
        builder: (context, snapshot){
        if(!snapshot.hasData){
          return Container(width:300,
          //color: Colors.black,
          height: 200,
          alignment: Alignment.center,
            child: CircularProgressIndicator());
        }
        else{
         return Container(
           padding: EdgeInsets.symmetric(horizontal:10,vertical:13),
           child: Column(
            children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                 Image.asset("assets/images/${snapshot.data[0]}.png",height:110,width:120,fit: BoxFit.cover,),
                 Text("VS",style:GoogleFonts.montserrat(
                fontWeight: FontWeight.w700,fontSize: 29,color: Colors.black
             )),  
             SizedBox(width: 2,),  
             Image.asset("assets/images/${snapshot.data[2]}.png",height:110,width:120,fit:BoxFit.cover),
               ],),
               SizedBox(height:8),
               Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: <Widget>[
               Text(snapshot.data[1],style:GoogleFonts.montserrat(
                fontWeight: FontWeight.w700,fontSize: 21,color: getmatchcolor(snapshot.data[1])
             )),
              Text(snapshot.data[3],style:GoogleFonts.montserrat(
                fontWeight: FontWeight.w700,fontSize: 21,color: getmatchcolor(snapshot.data[3])
             )),
            
               ],),
                SizedBox(height:3),
             Text(snapshot.data[4],style:GoogleFonts.montserrat(
                fontWeight: FontWeight.w700,fontSize: 20,color: Colors.red[600]))
                ,SizedBox(height: 10,),
               Expanded(child:Text(snapshot.data[5],style:GoogleFonts.montserrat(
                fontWeight: FontWeight.w800,fontSize: 16,color: Colors.black)
         )),
         ],));
        }
      },)
    ),
       SizedBox(height:15),
         Container(
            padding: EdgeInsets.symmetric(vertical:6,horizontal: 10)  ,
            alignment: Alignment.centerLeft,
           child:
           Text("Future Matches",style:GoogleFonts.montserrat(
                fontWeight: FontWeight.w700,fontSize: 20,color: Colors.black)
         )),
         SizedBox(height: 10,),
         dataisshare==false?Container(
           alignment: Alignment.center,
           child:CircularProgressIndicator())
           : CarouselSlider.builder(itemCount: iplmatchs.length, 
             options: CarouselOptions(
             viewportFraction:0.8,
             enableInfiniteScroll: true,
             autoPlay: true,
             autoPlayInterval: Duration(seconds: 8),
             autoPlayAnimationDuration: Duration(milliseconds:800),
             autoPlayCurve: Curves.easeIn,
             enlargeCenterPage: true,
             scrollDirection: Axis.horizontal
           ),
           itemBuilder:(context,index) {
            return  
            Container(
             // margin: EdgeInsets.only(left:20,right: 30),
             
          height: 285,width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color:Colors.orange[200]),
           
           child: Container(padding: EdgeInsets.symmetric(horizontal:10,vertical:15),
             child:Column(
            children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                 Image.asset(getimage(index),height:100,width:110,fit: BoxFit.cover,),
                 Text("VS",style:GoogleFonts.montserrat(
                fontWeight: FontWeight.w700,fontSize: 29,color: Colors.black
             )),  
             SizedBox(width: 2,),  
             Image.asset(getimage1(index),height:100,width:110,fit:BoxFit.cover),
               ],),
               SizedBox(height:8),
               Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: <Widget>[
               Text(getstr(index),style:GoogleFonts.montserrat(
                fontWeight: FontWeight.w700,fontSize: 20,color: getmatchcolor(getstr(index))
             )),
                Text(getstr1(index),style:GoogleFonts.montserrat(
                fontWeight: FontWeight.w700,fontSize: 20,color: getmatchcolor(getstr1(index))
                  )),
            ],),
                SizedBox(height:4),
             Text("${matchnumber[index]}",style:GoogleFonts.montserrat(
                fontWeight: FontWeight.w700,fontSize: 18,color: Colors.red))
                ,SizedBox(height: 4,),
               Expanded(child:Text(getonlystring(index),textAlign: TextAlign.center,
               style:GoogleFonts.montserrat(
                fontWeight: FontWeight.w900,fontSize: 14,color: Colors.black)))
         ,
         ],)));
           }
           
           )
    ]))])));
   
    
     }
}