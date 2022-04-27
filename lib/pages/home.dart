import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late String _userToDo;
  List todoList=[];

  @override
  void initState() {
    super.initState();

    todoList.addAll(['buy milk', 'Wash dishes', 'Купить кратошку']);
  }

  void _menuOpen() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.green[200],
          appBar: AppBar(
            backgroundColor: Colors.green[900],
            title: Text('Меню'),),
            body: Row(
              children: [
                Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.green[600],
                       //minimumSize: const Size.fromHeight(50),
                      ),
                      onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                      },
                      child: Text('На главную'),),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.green[600],
                        //minimumSize: const Size.fromHeight(50),
                      ),
                      onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamedAndRemoveUntil(context, '/shoppingFood', (route) => false);
                      },
                      child: Text('Список покупок (еда)'),),
                  ]
                ),
              ],
            ),
        );
      })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[200],
      appBar: AppBar(
        backgroundColor: Colors.brown[600],
        title: Text('Список дел'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.menu_open_sharp),
            onPressed: _menuOpen,
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Text('Нет записей');
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: Key(snapshot.data!.docs[index].id),
                  child: Card(
                    child: ListTile(
                      title: Text(snapshot.data!.docs[index].get('item')),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.brown[600],
                        ),
                        onPressed: () {
                          FirebaseFirestore.instance.collection('items').doc(snapshot.data!.docs[index].id).delete();
                        },
                      ),
                    ),
                  ),
                  onDismissed: (direction) {
                    FirebaseFirestore.instance.collection('items').doc(snapshot.data!.docs[index].id).delete();
                  },
                );
              }
          );
        },
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[900],
        onPressed: (){
          showDialog(context: context, builder: (BuildContext context){
            return AlertDialog(
              title: Text('Добавить элемент'),
              content: TextField(
                onChanged: (String value){
                  _userToDo = value;
                },
              ),
              actions: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.green[600],
                    //minimumSize: const Size.fromHeight(50),
            ),
                    onPressed: () {
                  FirebaseFirestore.instance.collection('items').add({'item': _userToDo});
                  Navigator.of(context).pop();
                }, child: Text('Добавить'))
              ],
            );
          });
        },
        child: Icon(
          Icons.add,
          color: Colors.green[200],
        )
      ),
    );
  }
}
