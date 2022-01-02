import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_flutter/add_page.dart';
import 'package:sqflite_flutter/db/users_database.dart';
import 'package:sqflite_flutter/edit_page.dart';
import 'package:sqflite_flutter/model/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UserModel> userList = [];

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
        actions: [
          InkWell(
            child: Container(
                padding: EdgeInsets.only(right: 30), child: Icon(Icons.delete)),
            onTap: () {
              setState(() {
                deleteallUsers();
              });
            },
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: Stack(
          children: [
            ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, index) {
                  return _userItemWidget(userList[index]);
                  // return Text("data "+userList[index].toString());
                }),

            //
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Container(
            //     width: MediaQuery.of(context).size.width,
            //     margin: EdgeInsets.all(10),
            //
            //     child: Row(
            //       children: [
            //       FloatingActionButton(
            //         onPressed: () {
            //           setState(() {
            //             deleteallUsers();
            //           });
            //
            //         },
            //         backgroundColor: Colors.redAccent,
            //         child: const Icon(Icons.delete),
            //       ),
            //
            //         Spacer(),
            //
            //         FloatingActionButton(
            //           onPressed: () {
            //             Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                 builder: (context) => AddPage(),
            //               ),
            //             ).then((value) {
            //               getAllUsers();
            //             });
            //           },
            //           backgroundColor: Colors.green,
            //           child: const Icon(Icons.add),
            //         ),
            //
            //
            //       ],
            //     ),
            //   ),
            // )
          ],
        ),
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

  void getAllUsers() async {
    userList = await UsersDatabase.instance.readAllUsers();
    setState(() {});
  }

  void deleteallUsers() async {
    await UsersDatabase.instance.deleteAll();
    userList = await UsersDatabase.instance.readAllUsers();
    setState(() {});
  }

  Widget _userItemWidget(UserModel userModel) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150,
      margin: EdgeInsets.only(right: 10, left: 10, bottom: 10),
      decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () async {
                          await UsersDatabase.instance.delete(userModel.id!);
                          getAllUsers();
                          setState(() {});
                        },
                        child: Icon(
                          Icons.delete,
                          size: 40,
                          color: Colors.red,
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditPage(
                              userModel: userModel,
                            ),
                          ),
                        ).then((value) {
                          getAllUsers();
                        });
                      },
                      child: Icon(
                        Icons.edit,
                        size: 40,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    userModel.name + " " + userModel.family,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    userModel.phoneNumber.toString(),
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
