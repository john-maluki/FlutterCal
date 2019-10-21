import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Interest Calculater',
    home: SIForm(),
    theme: ThemeData(
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent,
      brightness: Brightness.dark,
    ),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SIFormState();
  }
}

class SIFormState extends State<SIForm> {
  var _formKey = GlobalKey<FormState>();
  final _minimumPadding = 5.0;
  List<String> _currencies = ['Rupees', 'Dolars', 'Pounds'];
  var _currentItemSelected = 'Rupees';
  TextEditingController principalControler = TextEditingController();
  TextEditingController roiControler = TextEditingController();
  TextEditingController termControler = TextEditingController();
  String displayResult = '';
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      // resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text('Simple Interest Calculator'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(_minimumPadding * 2),
          child: ListView(
            children: <Widget>[
              getImageAsset(),
              Padding(
                padding: EdgeInsets.only(
                  top: _minimumPadding,
                  bottom: _minimumPadding,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: principalControler,
                  validator: (String inputValue) {
                    if (inputValue.isEmpty) {
                      return 'Please enter principal Amount';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Principal',
                    hintText: 'Enter Principal e.g 1200',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: _minimumPadding,
                  bottom: _minimumPadding,
                ),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: roiControler,
                  decoration: InputDecoration(
                    labelText: 'Rate Of Interest',
                    hintText: 'In Percent',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: _minimumPadding,
                  bottom: _minimumPadding,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: termControler,
                        decoration: InputDecoration(
                          labelText: 'Term',
                          hintText: 'Time in years',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: _minimumPadding * 5,
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        items: _currencies.map((String currency) {
                          return DropdownMenuItem(
                            value: currency,
                            child: Text(currency),
                          );
                        }).toList(),
                        value: _currentItemSelected,
                        onChanged: (String newValueSelected) {
                          _onDropDownItemSelected(newValueSelected);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: _minimumPadding,
                  bottom: _minimumPadding,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        child: Text('Calculate'),
                        onPressed: () {
                          setState(() {
                            if (this._formKey.currentState.validate()) {
                              this.displayResult = _calculateTotalReturns();
                            }
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RaisedButton(
                        child: Text('Reset'),
                        onPressed: () {
                          setState(() {
                            _reset();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(
                  _minimumPadding,
                ),
                child: Text(this.displayResult),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage imageAsset = AssetImage('images/student.jpg');
    Image image = Image(
      image: imageAsset,
      width: 125.0,
      height: 125.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding * 10),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  String _calculateTotalReturns() {
    double principal = double.parse(principalControler.text);
    double roi = double.parse(roiControler.text);
    double term = double.parse(termControler.text);

    double totalAmountPayable = principal + (principal * roi * term) / 100;
    String result =
        'After $term years, your investment will be worthy $totalAmountPayable $_currentItemSelected';

    return result;
  }

  void _reset() {
    principalControler.text = '';
    roiControler.text = '';
    termControler.text = '';

    displayResult = '';
    _currentItemSelected = _currencies[0];
  }
}
