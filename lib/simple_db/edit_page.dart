
import 'package:flutter/material.dart';
import 'package:sqflite_flutter/simple_db/db/users_database.dart';
import 'package:sqflite_flutter/simple_db/model/user_model.dart';

class EditPage extends StatefulWidget {
  UserModel userModel;
  EditPage({required this.userModel ,Key? key}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {

  late UserModel userModel;

  var _nameController = TextEditingController();
  var _familyController = TextEditingController();
  var _phoneController = TextEditingController();



  @override
  void initState(){

    _nameController.text = widget.userModel.name;
    _familyController.text = widget.userModel.family;
    _phoneController.text = widget.userModel.phoneNumber.toString();

   super.initState();
  }

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

              Directionality(
                textDirection: TextDirection.rtl,
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter name',
                  ),
                ),
              ),
              SizedBox(height: 5,),
              Directionality(
                textDirection: TextDirection.rtl,
                child: TextField(
                  controller: _familyController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter family',
                  ),
                ),
              ),
              SizedBox(height: 5,),
              Directionality(
                textDirection: TextDirection.rtl,
                child: TextField(


                  controller: _phoneController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter phone number',
                  ),
                ),
              ),
              SizedBox(height: 5,),

              RaisedButton(
                  child: Text("update user"),
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

                    updateUser();
                    List<UserModel> list = await UsersDatabase.instance.readAllUsers();
                    List<UserModel> list2 = list;
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("user updated successfuly")));

                  })

            ],
          ),
        ),
      ),
    );
  }


  Future updateUser() async {

    final userModel = widget.userModel.copy(
      isMarried: true,
      phoneNumber: int.parse(_phoneController.text),
      name: _nameController.text,
      family: _familyController.text,
    );

    await UsersDatabase.instance.update(userModel);
  }


  // void getUserInfo() async {
  //    userModel = await UsersDatabase.instance.readNote(widget.itemId);
  // }

}


