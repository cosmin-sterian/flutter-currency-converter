import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency converter',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const double _ConversionRate = 4.87;
  static final RegExp _FormatRegexp = RegExp(r'^\d+(\.\d*)?$');

  String _currencyString;
  double _currency;

  void _updateCurrencyString(String currencyString) {
    _currencyString = currencyString;
    // setState(() {
    //   _currency = double.parse(currencyString) * _ConversionRate;
    // });
  }

  void _updateCurrency() {
    setState(() {
      _currency = double.parse(_currencyString) * _ConversionRate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Image.network(
              'https://www.romaniajournal.ro/wp-content/uploads/2016/01/bani1.jpg'),
          TextField(
            keyboardType: const TextInputType.numberWithOptions(signed: true),
            maxLength: 20,
            decoration: const InputDecoration(
                prefixText: 'EUR',
                contentPadding: EdgeInsets.symmetric(horizontal: 10)),
            onChanged: _updateCurrencyString,
          ),
          if (_currency != null) Text('$_currency RON'),
          TextButton(
            child: const Text('Convert'),
            onPressed: () {
              // TODO(cosmin-sterian): if text field valid
              _updateCurrency();
            },
          ),
        ],
      ),
    );
  }
}
