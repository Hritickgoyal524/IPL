import 'package:flutter/material.dart';

class Iplmatche{
  final String firstteam;
final String firstsc;
final String secondteam;
final String secondsc;
Iplmatche({this.firstteam,this.firstsc,this.secondteam,this.secondsc});
}
getmatchcolor(String color){
  if(color=="DC"){
    return Colors.lightBlue;
  }
  else if(color=="RR"){
return Colors.pink;
  }
  else if(color=="CSK"){
    return Colors.amber;
  }
  else if(color=="RCB"){
    return Colors.redAccent;
  }
  else if(color=="KXIP"){
    return Colors.red;
  }
  else if(color=="SRH"){
    return Colors.deepOrange;
  }
 else if(color=="MI"){
    return Colors.indigo;
  }
  else if(color=="NTA"){
    return Colors.white;
  }
  }
  class Iplteam{
    final teamname;
    final teamsc;
    final String url;
    final List<Color> colors;
    Iplteam({this.teamname,this.teamsc,this.url,this.colors});
  }
