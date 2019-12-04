import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_list/loginscreen.dart';
import 'todolistscreen.dart';
import "models/items.dart";

class AddItemScreen extends StatefulWidget {
String token;
  
  AddItemScreen(this.token);

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  TextEditingController inputCtrl = TextEditingController();
  String output = "";
  String message;

  Future<String>added(String text) async{
    var response = await http.post(
      "https://sleepy-hamlet-97922.herokuapp.com/todo_items?text=${text}",
      headers: {HttpHeaders.authorizationHeader: "bearer<${widget.token}>"},
    );
    if (response.statusCode == 200)
    {
      String serverText = response.body;
      Map<String, dynamic>data = json.decode(serverText);
      String answer = data["message"];
     // return answer;
       message = ("Succesfully sent");
    } 
    else 
    {
       message = ("Unable to send the item");
    }
    return message;
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To-Do List"),
      ),
      body: Padding(
        padding: EdgeInsets.all(35.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TextField(controller: inputCtrl,),
            RaisedButton(child: Text("Add+"),onPressed: ()async {
             await added(inputCtrl.text);
              List<Item> item_list = await items(widget.token);
        
              Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ToDoListScreen(item_list, widget.token)),
                  );
            },)
          ]),
          
      ),
    );
  }
}