import 'dart:developer';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

//Stateful widget
// A stateful widget overrides a createState() method which returns a state.

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  //Instantiate the state of the dynamic variable
  @override
  void initState() {
    _numberFrom = 0;
    super.initState();
  }

  //Properties
  double _numberFrom;
  String _resultMessage;

  //Measure Map
  final Map<String, int> _measuresMap = { //Maps allow you to insert key-value pairs
    'meters' : 0,
    'kilometers' : 1,
    'grams' : 2,
    'kilograms' : 3,
    'feet' : 4,
    'miles' : 5,
    'pounds' : 6,
    'ounces' : 7,

  };

 final dynamic _formulas = {
    '0':[1,0.001,0,0,3.28084,0.000621371,0,0],
    '1':[1000,1,0,0,3280.84,0.621371,0,0],
    '2':[0,0,1,0.0001,0,0,0.00220462,0.035274],
    '3':[0,0,1000,1,0,0,2.20462,35.274],
    '4':[0.3048,0.0003048,0,0,1,0.000189394,0,0],
    '5':[1609.34, 1.60934,0,0,5280,1,0,0],
    '6':[0,0,453.592,0.453592,0,0,1,16],
    '7':[0,0,28.3495,0.0283495,3.28084,0,0.0625, 1],
  };




  @override
  Widget build(BuildContext context) {
    final TextStyle inputStyle = TextStyle(fontSize: 20, color: Colors.blue[900]);
    final TextStyle lableStyle = TextStyle(fontSize: 24, color: Colors.blue[700]);
    return MaterialApp(
      title: 'Unit Converter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Unit Converter'),
        ),
        body: Container(
          padding:EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.all(20)),
                  Text('Value', style: lableStyle,),
                  TextField(
                    style: inputStyle,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Measure to be converted'),
                    onChanged: (text) {
                      var current = double.tryParse(text);
                      if (current != null) {
                        setState(() {
                          _numberFrom = current;
                        });
                      }
                    },
                  ),
                  //Spacer(),
                  Padding(padding: EdgeInsets.all(20)),
                  Text('From', style: lableStyle,),
                  MyDropDownStatefulWidget(),
                  //Spacer(),
                  Padding(padding: EdgeInsets.all(20)),
                  Text('To', style: lableStyle,),
                  MyDropDownStatefulWidgetTwo(),
                  //Spacer(flex: 2,),
                  Padding(padding: EdgeInsets.all(20)),
                  RaisedButton(child: Text('Convert', style: inputStyle,),
                      onPressed: (){
                        convert(_numberFrom, 'meters' , 'kilometers'); //FIXME: Don't hardcode here
                        log(_resultMessage.toString());
                      }),
                  //Spacer(flex: 2,),
                  Padding(padding: EdgeInsets.all(20)),
                  Text((_resultMessage == null) ? '' : _resultMessage.toString()),
                  //Spacer(flex: 8,)
                ],
              ),
            ),
        ),
      ),
    );
  }

  //Method to convert the values using measures Map

  void convert(double value, String from, String to){
    int nFrom = _measuresMap[from];
    int nTo = _measuresMap[to];
    var multiplier = _formulas[nFrom.toString()][nTo];
    var result =  value * multiplier;

    if (result == 0){
      _resultMessage = 'This conversion cannot be performed';
    }else{
      setState(() {
        _resultMessage = _resultMessage;
      });
    }
  }


}

//How can I pass the current state of dropdownValue to the MyApp state?
class MyDropDownStatefulWidgetTwo extends StatefulWidget {
  @override
  _MyDropDownStatefulWidgetTwoState createState() => _MyDropDownStatefulWidgetTwoState();
}

class _MyDropDownStatefulWidgetTwoState extends State<MyDropDownStatefulWidgetTwo> {
  String dropdownValue = 'meters';
  final List<String> _measures = [
    'meters',
    'kilometers',
    'grams',
    'kilograms',
    'feet',
    'miles',
    'pounds (lbs)',
    'ounce'
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.straighten_outlined),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(fontSize: 20, color: Colors.blue[900]),
      underline: Container(
        height: 2,
        width: double.infinity,
        color: Colors.blue,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: _measures
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}


//DropDown Component
class MyDropDownStatefulWidget extends StatefulWidget {
  MyDropDownStatefulWidget({Key key}) : super(key: key);

  @override
  _MyDropDownStatefulWidgetState createState() => _MyDropDownStatefulWidgetState();
}

class _MyDropDownStatefulWidgetState extends State<MyDropDownStatefulWidget> {
  String dropdownValue = 'meters'; //_startMeasure
  final List<String> _measures = [
    'meters',
    'kilometers',
    'grams',
    'kilograms',
    'feet',
    'miles',
    'pounds (lbs)',
    'ounce'
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.straighten_outlined),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(fontSize: 20, color: Colors.blue[900]),
      underline: Container(
        height: 2,
        width: double.infinity,
        color: Colors.blue,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: _measures
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}



//Converter Two dimensional array or MATRIX