import 'package:flutter/material.dart';

void main() => runApp(MyApp());

//Stateful widget
// A stateful widget overrides a createState() method which returns a state.

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  //Instatiate the state of the dynamic variable
  @override
  void initState() {
    _numberFrom = 0;
    super.initState();
  }

  double _numberFrom;
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
    return MaterialApp(
      title: 'Unit Converter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Unit Converter'),
        ),
        body: Center(
          child: Column(
            children: [
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Enter number'),
                onChanged: (text) {
                  var current = double.tryParse(text);
                  if (current != null) {
                    setState(() {
                      _numberFrom = current;
                    });
                  }
                },
              ),
              //Text('${_numberFrom}')
              Text((_numberFrom == null) ? '' : _numberFrom.toString()),
              DropdownButton<String>(items: _measures.map((value) {
                return
                  DropdownMenuItem<String>(child: Text(value),);
              }).toList(),
                  onChanged: (String newValue){})
            ],
          ),
        ),
      ),
    );
  }
}

//Stateless widget is a class that extends a StatelessWidget.
// Extending a stateless widget requires overriding a build method.
//The build method MUST return your app widgets etc

/*class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Converter',
      home: Scaffold(
        appBar: AppBar(title: Text('Unit Converter'),),
        body: Center(
          child: Text('Unit Converter App'),
        ),
      ),


    );
  }
}*/
