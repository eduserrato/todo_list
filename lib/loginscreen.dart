import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_list/models/items.dart';
import 'todolistscreen.dart';
import 'mainscreen.dart';
import 'models/items.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  Future<String> login(String username, String password) async {
    //try to login to https://sleepy-hamlet-97922.herokuapp.com/api/login            // SEND THE USER AND PASSWORD, THEN RESIVE TOKEN AND SEND 
                                                                                     // THE TOKE TO RESIVE THE SECRET MESSAGE

    //if successful, that is, status is 200
    //parse the response
    //return the token
    var response = await http.get("https://sleepy-hamlet-97922.herokuapp.com/api/login?username=${username}&password=${password}", );
     
      if (response.statusCode == 200)
      {
         String serverText = response.body;
        Map<String,dynamic>data = json.decode(serverText);
        String token = data["token"];

          return token;
      }
    //if not successful return null
      else
      {
        return null;
      }
  }

  

  Future<String> getSecretMessage(String token) async {
    //try to retrieve secret
    //set HttpHeaders.authorizationHeader to Bearer token                      // HERE YOU SEND THE TOKEN AND RESIVE THE SECRET MESSAGE
   
    //if successful, that is, status is 200
    //parse the response
    //return the secret message
    //if not successful, return null
    var response = await http.get(
      "https://sleepy-hamlet-97922.herokuapp.com/secret",
      headers: {HttpHeaders.authorizationHeader: "bearer<${token}>"},
    );
     

    if (response.statusCode == 200)
    {
      String answer = response.body;
      Map<String, dynamic> data = json.decode(answer);
      String message = data["message"];
      return message;
    }
    else 
    {
      return null;
    }
  }

  Future<String>register(String username, String password) async{
    var response = await http.post("https://sleepy-hamlet-97922.herokuapp.com/api/register?username=${username}&password=${password}",);
    //if (response.statusCode == 200)
    {
      String serverText = response.body;
      Map<String, dynamic>data = json.decode(serverText);
      String answer = data["message"];
      return answer;
    } 
   // else 
    //{
    
    //}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: usernameCtrl,
          ),
          TextField(
            controller: passwordCtrl,
          ),
          RaisedButton(
            child: Text("Login"),
            onPressed: () async {
              //Try to login and retrieve token
              String token = await login(usernameCtrl.text, passwordCtrl.text);

              //if token is valid
              if (token != null) {

                //try to fetch the secret info
                String secret = await getSecretMessage(token);

                //if successfully retrieved
                if (secret != null) {
                  List<Item> item_list = await items(token);
                  //navigate to MainScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ToDoListScreen(item_list, token)),
                  );
                }
              }
              
            },
          ),
          RaisedButton(
            child: Text("Register"),
            onPressed: ()async {

            
              String answer = await register(usernameCtrl.text, passwordCtrl.text);
            
              //navigate to
              //MainScreen("Secret constructor message")                          //YOU SEND THE INFO AND THEN YOU MAKE THE USERNAME 201 if susccesful

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MainScreen("${answer}"),
              ),
              );
            },
          )
        ],
      ),
    );
  }
}