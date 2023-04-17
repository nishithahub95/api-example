

 import 'dart:convert';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreentwo extends StatefulWidget {
   const HomeScreentwo({Key? key}) : super(key: key);

   @override
   State<HomeScreentwo> createState() => _HomeScreentwoState();
 }

 class _HomeScreentwoState extends State<HomeScreentwo> {
  List<Photos>photoList=[];
  
  Future<List<Photos>>getPhotos()async{
    var response=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data=jsonDecode(response.body.toString());
    if(response.statusCode==200){
      for(Map i in data){
        Photos photos=Photos(title: i['title'], url: i['url'],id: i['id']);
        photoList.add(photos);

      }
      return photoList;
    }else{
      return photoList;
    }
    
  }
  
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body: Column(
         children: [
           Expanded(
             child: FutureBuilder(
                 future: getPhotos(),
                 builder: (context,AsyncSnapshot<List<Photos>>snapshot){
                   return ListView.builder(
                       itemCount: photoList.length,
                       itemBuilder: (context,index){
                     return ListTile(
                       leading: CircleAvatar(
                         backgroundImage:NetworkImage(snapshot.data![index].url.toString()) ,
                       ),
                      title: Text(snapshot.data![index].title.toString()),
                       trailing:Text(snapshot.data![index].id.toString()) ,
                     );
                   });

             }),
           )
         ],
       ),
     );
   }

 }
 class Photos{
  String title,url;
  int id;
  Photos({required this.title,required this.url,required this.id});

 }
