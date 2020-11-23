import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const double _ConversionRate = 4.87;
  static const String _ErrorMessage = 'Please use digits and a dot only.';
  static final RegExp _formatRegexp = RegExp(r'^\d+(\.\d*)?$');

  bool _hasError = false;
  String _inputValue;
  double _currency;

  void _updateInputValue(String inputValue) {
    _inputValue = inputValue;
  }

  void _updateCurrency() {
    setState(() {
      _currency = double.parse(_inputValue) * _ConversionRate;
    });
  }

  void _onPressedConvert() {
    setState(() {
      _hasError = !_formatRegexp.hasMatch(_inputValue);
    });
    print('Has error: $_hasError');

    if (!_hasError) {
      _updateCurrency();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Image.network(
              'https://www.romaniajournal.ro/wp-content/uploads/2016/01/bani1.jpg'),
          Container(
            margin: const EdgeInsets.all(10),
            child: TextField(
              keyboardType: const TextInputType.numberWithOptions(signed: true),
              maxLength: 20,
              decoration: InputDecoration(
                  prefixText: 'EUR ',
                  errorText: _hasError ? _ErrorMessage : null),
              onChanged: _updateInputValue,
            ),
          ),
          Text(_currency == null ? '' : '$_currency RON'),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: ElevatedButton(
              child: const Text('Convert'),
              onPressed: () {
                _onPressedConvert();
              },
            ),
          ),
        ],
      ),
    );
  }
}
