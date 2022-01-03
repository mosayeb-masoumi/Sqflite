import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sqflite_flutter/list_object_db/db/combine_database.dart';
import 'package:sqflite_flutter/list_object_db/model/combine_model.dart';
import 'package:sqflite_flutter/list_object_db/model/detail_model.dart';

class CombinePage extends StatefulWidget {
  const CombinePage({Key? key}) : super(key: key);

  @override
  _CombinePageState createState() => _CombinePageState();
}

class _CombinePageState extends State<CombinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(right: 10 ,left: 10),
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            RaisedButton(
                child: Text("add to combine database"),
                onPressed: () {
                  addDataToDatabase();
                }),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
                child: Text("get data from combine database"),
                onPressed: () {
                  getDatafromDatabase();
                }),
          ],
        ),
      ),
    );
  }



  void addDataToDatabase() {
   DetailModel detailModel = DetailModel(name:"hassan",family: "rezai",city: "tehran");
   String jsonModel = jsonEncode(detailModel);

   print(jsonModel);


   List<DetailModel> detailList = [];
   detailList.add(DetailModel(name: "reza", family: "alipur", city: "qom"));
   detailList.add(DetailModel(name: "mina", family: "qolivand", city: "shiraz"));
   detailList.add(DetailModel(name: "shima", family: "shahsavand", city: "shush"));

   String jsonList = jsonEncode(detailList);
   print(jsonList);


   // add to database
   addToDB(jsonModel , jsonList);

  }


  Future addToDB(String jsonModel ,String jsonList) async {
    final model = CombineModel(
        title: "unique title",
        createdTime: DateTime.now(),
        detailModel: jsonModel,
        detailList:jsonList ,

    );
    await CombineDatabase.instance.create(model);
  }


  void getDatafromDatabase() async{
    List<CombineModel> combineList = await CombineDatabase.instance.readAllUsers();
    var title = combineList[0].title;
    String time = combineList[0].createdTime.toString();
    var jsonModel = combineList[0].detailModel;
    var jsonList = combineList[0].detailList;

    DetailModel detailModel = DetailModel.fromJson(jsonDecode(jsonModel));
    DetailModel detailModel2 = detailModel;


    List jsonResponse = json.decode(jsonList);
    List<DetailModel> listDetail = jsonResponse.map((x) => DetailModel.fromJson(x)).toList();
    List<DetailModel> listDetail2 = listDetail;


  }

}



