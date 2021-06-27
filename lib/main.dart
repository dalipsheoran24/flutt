

import 'package:flutt/database.dart';
import 'package:flutt/user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutt/covidReport.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController topicController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController dayController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController gmailController = TextEditingController();
  TextEditingController inputValueController = TextEditingController();

  List<UserInfo> list = [];
  DatabaseHelper dbHelper = DatabaseHelper();
  String value = "";


  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    await dbHelper.init();
    list = await dbHelper.fetchData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(mainAxisSize: MainAxisSize.min, children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextField(
                controller: topicController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: 'Topic',
                ),
              ),
              TextField(
                controller: nameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: 'Name',
                ),
              ),
              TextField(
                controller: dayController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: 'Day',
                ),
              ),
              TextField(
                controller: dateController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: 'Date',
                ),
              ),
              TextField(
                controller: inputValueController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Select',
                ),
              ),

            ],
          ),
        ),
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: Text('Submit'),
              onPressed: () async {
                String topic = topicController.text;
                String name = nameController.text;
                String day = dayController.text;
                String date = dateController.text;
                String gmail = gmailController.text;

                UserInfo userInfo =
                    UserInfo(topic, name, day, date, gmail, value);

                await dbHelper.insertdata(userInfo);
                list = await dbHelper.fetchData();
                setState(() {});

                topicController.text = "";
                nameController.text = "";
                dayController.text = "";
                dateController.text = "";
                gmailController.text = "";
              },
            ),
            DropdownButton<String>(
              items: [
                DropdownMenuItem<String>(
                  value: '1',
                  child: Center(
                    child: Text('One'),
                  ),
                ),
                DropdownMenuItem<String>(
                  value: '2',
                  child: Center(
                    child: Text('Two'),
                  ),
                ),
                DropdownMenuItem<String>(
                  value: '3',
                  child: Center(
                    child: Text('Three'),
                  ),
                )
              ],
              value: value == ""?"1":value,
              onChanged: (inputvalue) => {
                print(inputvalue.toString()),
                setState(() {
                  value = inputvalue;
                }),
              },
              hint: Text("Select"),
            ),
            ElevatedButton(onPressed: (){
              Navigator.push(context,MaterialPageRoute(
                  builder: (context)=>covid(),
                  )
              );
            },
              child: Text("CovidReport"),

              ),

            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    UserInfo userInfo = list[index];
                    return GestureDetector(
                      onLongPress: () async {
                        UserInfo info = list[index];
                        await dbHelper.deleteRecord(info.id);
                        list = await dbHelper.fetchData();
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: SingleChildScrollView(
                          child: Expanded(
                            child: Column(
                              children: [
                                Row(children: [
                                  Text("Topic:"),
                                  SizedBox(width: 8),
                                  Text(userInfo.topic)
                                ]),
                                Row(children: [
                                  Text("Name:"),
                                  SizedBox(width: 8),
                                  Text(userInfo.name)
                                ]),
                                Row(children: [
                                  Text("Day:"),
                                  SizedBox(width: 8),
                                  Text(userInfo.day)
                                ]),
                                Row(children: [
                                  Text("Date:"),
                                  SizedBox(width: 8),
                                  Text(userInfo.date)
                                ]),
                                Row(children: [
                                  Text("Gmail:"),
                                  SizedBox(width: 8),
                                  Text(userInfo.gmail),
                                ]),
                                Row(children: [
                                  Text("value:"),
                                  SizedBox(width: 8),
                                  Text(userInfo.inputValue),
                                ]),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ]),
    );
  }
}
