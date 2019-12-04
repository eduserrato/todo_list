import 'package:flutter/material.dart';
import 'additemscreen.dart';
import 'models/items.dart';

class ToDoListScreen extends StatefulWidget {
  List<Item> item_list;
String token;
  ToDoListScreen(this.item_list, this.token);

  @override
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  TextEditingController inputCtrl = TextEditingController();
  String output = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To-Do List"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RaisedButton(
              child: Text("Add Item +"),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddItemScreen(widget.token)),
                );
              }),
          Expanded(
            child: SizedBox(
                height: 100,
                child: ListView.builder(
                  itemCount: widget.item_list.length,
                  itemBuilder: (_, i) {
                    Item x = widget.item_list[i];
                    return CheckboxListTile(
                      
                      title:
                      Text(x.text == null ? "" : x.text, ),
                      value: x.completed,
                      onChanged: (bool new_value) {
                       setState(() {
                         new_value = !x.completed;
                          (x.completed = new_value); 
                          
                       });
                      },
                    );
                  },
                )),
          ),
         ],
      ),
    );
  }
}
