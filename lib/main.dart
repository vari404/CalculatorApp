import 'package:flutter/material.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CalculatorApp',
      theme: ThemeData(
        fontFamily: 'CustomFont',
      ),
      home: CalculatorHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String _display = '';
  double num1 = 0;
  double num2 = 0;
  String operator = '';

  void buttonPressed(String btnText) {
    setState(() {
      if (btnText == 'C') {
        _display = '';
        num1 = 0;
        num2 = 0;
        operator = '';
      } else if (btnText == '+' || btnText == '-' || btnText == '*' || btnText == '/') {
        if (_display.isNotEmpty) {
          num1 = double.parse(_display);
          operator = btnText;
          _display = '';
        }
      } else if (btnText == '=') {
        if (_display.isNotEmpty && operator.isNotEmpty) {
          num2 = double.parse(_display);
          calculateResult();
        }
      } else {
        // Handle decimal point and prevent multiple decimals
        if (btnText == '.' && _display.contains('.')) {
          return;
        } else {
          _display += btnText;
        }
      }
    });
  }

  void calculateResult() {
    double result = 0;
    switch (operator) {
      case '+':
        result = num1 + num2;
        break;
      case '-':
        result = num1 - num2;
        break;
      case '*':
        result = num1 * num2;
        break;
      case '/':
        if (num2 == 0) {
          _display = 'Error';
          return;
        } else {
          result = num1 / num2;
        }
        break;
      default:
        return;
    }
    _display = result.toString();
    num1 = 0;
    num2 = 0;
    operator = '';
  }

  Widget calcButton(String text, Color bgColor, Color textColor) {
    return GestureDetector(
      onTap: () {
        buttonPressed(text);
      },
      child: Container(
        margin: EdgeInsets.all(4),
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8), // Optional: Rounded corners
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 24, color: textColor),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {  // <-- Missing build method added here
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: Text('CalculatorApp'),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Column(
        children: [
          // Display area
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(24),
              child: Text(
                _display,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          // Buttons
          Container(
            child: GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                calcButton('C', Colors.redAccent[200]!, Colors.white),
                calcButton('/', Colors.deepOrange[400]!, Colors.white),
                calcButton('*', Colors.deepOrange[400]!, Colors.white),
                calcButton('-', Colors.deepOrange[400]!, Colors.white),
                calcButton('7', Colors.lightBlue[200]!, Colors.black),
                calcButton('8', Colors.lightBlue[200]!, Colors.black),
                calcButton('9', Colors.lightBlue[200]!, Colors.black),
                calcButton('+', Colors.deepOrange[400]!, Colors.white),
                calcButton('4', Colors.lightBlue[200]!, Colors.black),
                calcButton('5', Colors.lightBlue[200]!, Colors.black),
                calcButton('6', Colors.lightBlue[200]!, Colors.black),
                calcButton('=', Colors.greenAccent[400]!, Colors.white),
                calcButton('1', Colors.lightBlue[200]!, Colors.black),
                calcButton('2', Colors.lightBlue[200]!, Colors.black),
                calcButton('3', Colors.lightBlue[200]!, Colors.black),
                calcButton('0', Colors.lightBlue[200]!, Colors.black),
                calcButton('.', Colors.lightBlue[200]!, Colors.black),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
