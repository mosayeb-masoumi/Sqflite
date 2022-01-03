import 'package:flutter/material.dart';
import 'package:sqflite_flutter/db/users_database.dart';
import 'package:sqflite_flutter/model/user_model.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

  TextEditingController _nameController = TextEditingController();
  TextEditingController _familyController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("add new user"),
        ),

        body: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [

              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter name',
                ),
              ),
              SizedBox(height: 5,),
              TextField(
                controller: _familyController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter family',
                ),
              ),
              SizedBox(height: 5,),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter phone number',
                ),

                  keyboardType: TextInputType.number

              ),
              SizedBox(height: 5,),


              RaisedButton(
                child: Text("add user"),
                  onPressed: () async {
                   if(_nameController.text =="" || _nameController.text==null){
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("enter name please!!!")));
                     return;
                   }

                   if(_familyController.text =="" || _familyController.text==null){
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("enter family please!!!")));
                     return;
                   }

                   if(_phoneController.text =="" || _phoneController.text==null){
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("enter phone please!!!")));
                     return;
                   }

                   addUser();
                   List<UserModel> list = await UsersDatabase.instance.readAllUsers();
                   List<UserModel> list2 = list;
                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("user added successfuly")));

                  })

            ],
          ),
        ),
      ),
    );
  }


  Future addUser() async {

    final user = UserModel(
        isMarried: true,
        phoneNumber: int.parse(_phoneController.text),
        name: _nameController.text,
        family: _familyController.text,
        createdTime: DateTime.now()
    );
    await UsersDatabase.instance.create(user);
  }

}
