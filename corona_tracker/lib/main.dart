import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'graph.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/graph': (context) => GraphPage(),
      },
      title: 'Corona Tracker',
    );
  }
}

typedef void Func();


var jsonResponse;
List data ;
class CallAPI{

  static String url = 'https://api.covid19india.org/data.json#';

  static void getData(Func f) async{
    var response = await http.get(url);
    if (response.statusCode == 200) {
      jsonResponse = convert.jsonDecode(response.body);
      data = jsonResponse['cases_time_series'];
      print("API SUCCESS!");
      f();
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class DataPoint{
  int date;
  int num;


  DataPoint(this.date, this.num);

}

class _MyHomePageState extends State<MyHomePage> {

  List<DataPoint> timeline = List<DataPoint>();
  List<DataPoint> timeline1 = List<DataPoint>();
  List<DataPoint> timeline2 = List<DataPoint>();


  void loadData(){

int index;


     setState(() {
       for(index= 0;index<data.length;index++)
       {jsonResponse = data[index];

         timeline.add(
             DataPoint(int.parse(jsonResponse['totalconfirmed']),index));

         timeline1.add(
           DataPoint(int.parse(jsonResponse['totaldeceased']),index ));
       timeline2.add(
           DataPoint(int.parse(jsonResponse['dailyrecovered']),index ));


       }

     }



     );

  }


  @override
  void initState() {
    super.initState();
    CallAPI.getData(loadData);

  }

  @override
  Widget build(BuildContext context) {

    if(jsonResponse == null){
      return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'CoronaVirus Tracker',
            ),
          ),
          backgroundColor: Colors.purple,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                child: Icon(Icons.show_chart, color: Colors.white,),
                onTap: (){},
                splashColor: Colors.red,
              ),
            ),
          ],
        ),
        body: Center(child: Text('Loading Data...'),),
      );
    }
    else{
      return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'CoronaVirus Tracker',
            ),
          ),
          backgroundColor: Colors.purple,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                child: Icon(Icons.show_chart, color: Colors.white,),
                onTap: (){
                  Navigator.pushNamed(context, '/graph', arguments:ScreenArguments(timeline: timeline,timeline1: timeline1,timeline2: timeline2
                  ));

                },
                splashColor: Colors.red,
              ),
            ),
          ],
        ),
        body: ShowListView(timeline),
      );
    }
  }
}

class ShowListView extends StatelessWidget {
  final List<DataPoint> timeline;

  ShowListView(this.timeline);

  @override
  Widget build(BuildContext context) {
    print(timeline.length);
    print("\n\n");
    return ListView.builder(
        itemCount: timeline.length,
        itemBuilder: (context, index){
          return Column(
              children: <Widget>[
                ListTile(
                  leading: Text("${timeline[index].date}"),
                  title:  Center(child: Text("Total Cases: ${timeline[index].num}")),
                ),
                Divider(),
              ]
          );
        }
    );
  }
}


class ScreenArguments {
     ScreenArguments({ this.timeline, this.timeline1,this.timeline2});
    final List timeline;
     final List timeline1;
     final List timeline2;

   }