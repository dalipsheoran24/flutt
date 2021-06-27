
import 'package:flutt/covidReport.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
void main() {
  runApp(covid());
}
class covid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      );
    }
  }
  class MyHomePage extends StatefulWidget {
    @override
    _MyHomePageState createState() => _MyHomePageState();
  }

  class _MyHomePageState extends State<MyHomePage> {

    @override
    int NewConfirmed;
    int TotalConfirmed;
    int NewDeaths;
    int TotalDeaths;
    int NewRecovered;
    int TotalRecovered;

    void getData() async{
      Uri myuri = Uri.parse("https://api.covid19api.com/summary");
      Response response = await get(myuri);
      if(response.statusCode==200)
      {
        Map<String, dynamic> map = jsonDecode(response.body);
        Map<String, dynamic> globalMap = map["Global"];
        NewConfirmed = globalMap["NewConfirmed"];
        print(NewConfirmed );
        TotalConfirmed = globalMap["TotalConfirmed"];
        print(TotalConfirmed);
        NewDeaths= globalMap["NewDeaths"];
        print(NewDeaths);
        TotalDeaths= globalMap["TotalDeaths"];
        print(TotalDeaths);
        NewRecovered= globalMap["NewRecovered"];
        print(NewRecovered);
        TotalRecovered= globalMap["TotalRecovered"];
        print(TotalRecovered);
      }
      else
      {
        NewConfirmed=null;
        print(NewConfirmed);
        TotalConfirmed=null;
        print(TotalConfirmed);
        NewDeaths=null;
        print(NewDeaths);
        TotalDeaths=null;
        print(TotalDeaths);
        NewRecovered=null;
        print(NewRecovered);
        TotalRecovered=null;
        print(TotalRecovered);
      }
    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: Text('covid'),
          ),
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "COVID-19 Live Stats !",
                    style: TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  RaisedButton(
                    child: Text("Get Data"),
                    onPressed: () async{

                      await getData();
                      setState(() {

                      });
                    },
                  ),
                  Text(
                    "New Confirmed = $NewConfirmed",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.0,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    "Total Confirmed = $TotalConfirmed",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.0,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    "New Deaths = $NewDeaths",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.0,
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    "Total Deaths = $TotalDeaths",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.0,
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    "New Recovered = $NewRecovered",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.0,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    "Total Recovered = $TotalRecovered",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.0,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),

          )


      );
    }
  }

