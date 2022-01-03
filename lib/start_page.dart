
import 'package:flutter/material.dart';
import 'package:sqflite_flutter/list_object_db/combine_page.dart';
import 'package:sqflite_flutter/simple_db/home_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(right: 10 ,left: 10),
        child: Column(
          children: [
             SizedBox(height: 100,),
             RaisedButton(
                 child: Text("add edit user"),
                 onPressed: (){
                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => HomePage()),
                   );
                 }),

            SizedBox(height: 10,),
            RaisedButton(
                child: Text("add edit list and object"),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CombinePage()),
                  );
                }),

          ],
        ),
      ),

    );
  }
}
