import 'package:flutter/material.dart';
import 'package:todoapp/constant/coloors.dart';
import 'package:todoapp/model/todo.dart';
import 'package:todoapp/widgets/todo_item.dart';

class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // const Home({Key? key}) : super(key: key);
  final todoList = ToDo.todoList();
  final _todoController = TextEditingController();
  List<ToDo> _foundToDo =[];

  void initState(){
    _foundToDo = todoList;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50, bottom: 20),
                        child: Text('All Todo'+"'"+'s',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      for( ToDo todo in _foundToDo.reversed)
                        TodoItem(
                          todo: todo,
                          onToDoChanged: _handleToDoChange,
                          onDeleteItem: _deleteToDoItem ,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(child: Container(
                margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0,0.0),
                    blurRadius: 10.0,
                    spreadRadius: 0.0,
                  )],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _todoController,
                  decoration: InputDecoration(
                    hintText: 'add new todo item',
                    border: InputBorder.none,
                  ),
                ),
              )),
              Container(
                margin: EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                ),
                child: ElevatedButton(
                  child: Text('+', style: TextStyle(fontSize: 45),),
                  onPressed: (){
                    _addTodoItem(_todoController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(50, 50),
                    elevation: 10,

                  ),
                ),
              ),

            ],),
          )
        ],
      ),
    );
  }
  void _handleToDoChange(ToDo todo){
    setState(() {
      todo.isdone = !todo.isdone;
    });
  }

  void _deleteToDoItem(String id){
    setState(() {
      todoList.removeWhere((item) => item.id  == id);
    });
  }
  void _addTodoItem(String todo){
    setState(() {
      todoList.add(
          ToDo(
              id: DateTime.now().microsecondsSinceEpoch.toString(),
              todoText: todo));
      _todoController.clear();
    });
  }
  void runFilter(String enterdKeyword){
    List<ToDo> results= [];
    if(enterdKeyword.isEmpty ){
      results = todoList;
    }else{
      results = todoList.where((item) => item.todoText!.toLowerCase().contains(enterdKeyword.toLowerCase())).toList();
      setState(() {
        _foundToDo= results;
      });
    }
  }

  Widget searchBox(){
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
      ),
      child: TextField(
        onChanged: (value) => runFilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          Container(
            height: 50,
            width: 50,
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/Untitled design.png'),
            ),
          )
        ],

      ),
    );
  }
}
