
import 'package:flutter/material.dart';
import 'package:sqflite_flutter/add_page.dart';
import 'package:sqflite_flutter/db/users_database.dart';
import 'package:sqflite_flutter/model/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<UserModel> userList =[];

  @override
  void initState() {
    getAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("list of users"),
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddPage(),
              ),
            ).then((value) {
              getAllUsers();
            });
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.add),
        ),
    );
  }


  void getAllUsers() async{
    userList = await UsersDatabase.instance.readAllUsers();
    List<UserModel> list2 = userList;
  }


}

