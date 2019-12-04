import 'package:todo_list/loginscreen.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class Item{
  int id;
  String text;
  bool completed;
  DateTime created_at;
  int user_id;

    Item({this.id, this.created_at, this.user_id, this.completed, this.text});

    factory Item.fromJson(Map<String, dynamic> json){
      return Item(id: json["id"], created_at: DateTime.parse(json["created_at"]), user_id: json["user_id"], completed: json["completed"],text: json["text"],);  
    }
}


Future<List<Item>> items(String token) async {
  List<Item> items_list = [];

  var response = await http.get(
      "https://sleepy-hamlet-97922.herokuapp.com/todo_items",
      headers: {HttpHeaders.authorizationHeader: "bearer<${token}>"},
    );
    if (response.statusCode == 200)
      {
        print("retrieved items");
         String serverText = response.body;
        List<dynamic> data = json.decode(serverText);

        for(int i = 0; i < data.length; i++)
        {
           items_list.add(Item.fromJson(data[i]));
        }
        return items_list;
      }
    //if not successful return null
      else
      {
        return null;
      }
}