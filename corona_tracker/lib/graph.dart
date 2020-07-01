import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'main.dart';




class GraphPage extends StatefulWidget {
  @override
  _GraphPageState createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  List<charts.Series<DataPoint, int>> seriesLineData;
generate(){
  final ScreenArguments args = ModalRoute.of(context).settings.arguments;




  seriesLineData.add(
    charts.Series(
      colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
      id: 'Covid',
      data: args.timeline2,
      domainFn: (DataPoint dp, _) => dp.date,
      measureFn: (DataPoint dp, _) => dp.num,
    ),
  );


  seriesLineData.add(
    charts.Series(
      colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
      id: 'Covid',
      data: args.timeline1,
      domainFn: (DataPoint dp, _) => dp.date,
      measureFn: (DataPoint dp, _) => dp.num,
    ),
  );
  seriesLineData.add(
    charts.Series(
      colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
      id: 'Covid',
      data: args.timeline,
      domainFn: (DataPoint dp, _) => dp.date,
      measureFn: (DataPoint dp, _) => dp.num,
    ),
  );
}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    seriesLineData = List<charts.Series<DataPoint, int>>();
    generate();
  }



  @override
  Widget build(BuildContext context) {






    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'CoronaVirus Tracker',
          ),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  'COVID STATS',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
                Expanded(
                  child: charts.LineChart(
                      seriesLineData,
                      defaultRenderer: new charts.LineRendererConfig(
                          includeArea: true, stacked: true),
                      animate: true,
                      animationDuration: Duration(seconds: 5),
                      behaviors: [
                        new charts.ChartTitle('Date',
                            behaviorPosition: charts.BehaviorPosition.bottom,
                            titleOutsideJustification:charts.OutsideJustification.middleDrawArea),
                        new charts.ChartTitle('People',
                            behaviorPosition: charts.BehaviorPosition.start,
                            titleOutsideJustification: charts.OutsideJustification.middleDrawArea),

                      ]
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}




