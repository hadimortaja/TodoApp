import 'package:flutter/material.dart';
import 'package:todo_app/model/todo_item.dart';
import 'package:todo_app/utils/database_client.dart';
class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  TextEditingController _controller =TextEditingController();
  var db =DatabaseHelper();
  final List<TodoItem>_itemsList =<TodoItem>[];

  @override
  void initState() {
    super.initState();
    _readTodoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
                itemCount: _itemsList.length,
                itemBuilder: (_,int index){
                  return Card(
                    elevation: 2,
                    color: Colors.white,
                    child: ListTile(
                      title: _itemsList[index],
                      onLongPress: ()=>print("Long Press"),
                      trailing: Listener(
                        key: Key(_itemsList[index].itemName),
                        child: Icon(Icons.remove_circle,color: Colors.redAccent,),
                        onPointerDown: (pointerEvent)=>_handleDelete(_itemsList[index].id,index),
                      ),
                    ),
                  );
                }
            ),
          ),
          Divider(height: 1,),
        ],
      ),
      floatingActionButton:FloatingActionButton(
        onPressed: _showFormDialog,
        child: ListTile(
          title: Icon(Icons.add),
        ),
        backgroundColor: Colors.black,
      ),
    );
  }
  _showFormDialog(){
    var alert =AlertDialog(
      content: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              autofocus: true,
              decoration: InputDecoration(
                labelText: "Item",
                labelStyle: TextStyle(color: Colors.black),
                hintText: "e.g buy breads",
                icon: Icon(Icons.add_alert,color: Colors.black,)
              ),
            ),
          )
        ],
      ),
      actions: [
        FlatButton(
          onPressed:(){
            _handleSubmit(_controller.text);
            _controller.clear();
            Navigator.of(context).pop();
          } ,
          child: Text("Save"),
        ),
        FlatButton(
          onPressed: ()=>Navigator.of(context).pop(),
          child: Text("Cancel",style: TextStyle(color: Colors.black),),
        )
      ],
    );
    showDialog(context: context,builder: (_){
      return alert;
    });
  }
  _readTodoList()async{
    List items =await db.getAllItems();
    items.forEach((item) {
      // TodoItem todoItem = TodoItem.fromMap(item);
      // print("DB items = ${todoItem.itemName}");
      setState(() {
        _itemsList.add(TodoItem.map(item));

      });
    });
  }
  _handleSubmit(String text)async{
    TodoItem item = TodoItem(text, DateTime.now().toIso8601String());
    int savedItemId =await db.saveItem(item);
    TodoItem saveditem =await db.getTodoItem(savedItemId);
    setState(() {
      _itemsList.insert(0, saveditem);
    });

  }
  _handleDelete(int id, int index)async {
    await db.deleteItem(id);
    setState(() {
      _itemsList.removeAt(index);
    });
  }

}

