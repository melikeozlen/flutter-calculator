import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:calculator/colors/colors.dart';

void main() {
  runApp(CalculatorApp());
}

const List<String> buttonLabels = [
  'AC',
  'DEL',
  '%',
  '+',
  '7',
  '8',
  '9',
  '-',
  '4',
  '5',
  '6',
  '/',
  '1',
  '2',
  '3',
  '*',
  '.',
  '='
];

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hesap Makinesi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = '';
  String result = '';
  void _onButtonPressed(String buttonText) {
    setState(() {
      if (result != '') {
        input = result;
        result = '';
      }
      if (buttonText == '=') {
        try {
          final expression = Parser().parse(input);
          final evaluated =
              expression.evaluate(EvaluationType.REAL, ContextModel());
          result = evaluated.toString();
        } catch (e) {
          result = 'Hata';
        }
      } else if (buttonText == 'AC') {
        result = '';
        input = '';
      } else if (buttonText == 'DEL') {
        input = removeLastCharacter(input);
      } else {
        input += buttonText; // Diğer durumlarda input'a düğme etiketini ekle
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    input,
                    style: const TextStyle(fontSize: 34.0),
                  ),
                  Text(
                    result != '' ? "= " + result : '',
                    style: const TextStyle(fontSize: 34.0),
                  )
                ],
              ),
            ),
          ),
          const Divider(
            height: 1.0,
          ),
          Expanded(
            flex: 4,
            child: Wrap(
              children: buttonLabels.map((label) {
                return Container(
                  margin: EdgeInsets.all(10.5),
                  decoration: BoxDecoration(
                      color: label == "AC"
                          ? Colors.red.shade300
                          : label == "="
                              ? HexColor("#66FF7F")
                              : HexColor(grapbuttonBG),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: SizedBox(
                    width: label == "="
                        ? (3 * (MediaQuery.of(context).size.width / 4) - 25)
                        : (MediaQuery.of(context).size.width / 4) - 25,
                    height: (MediaQuery.of(context).size.height / 8) - 15,
                    child: Center(
                        child: TextButton(
                      onPressed: () => _onButtonPressed(label),
                      child: Text(
                        label,
                        style: TextStyle(
                            color: (label == "AC" || label == "=")
                                ? Colors.white
                                : (double.tryParse(label) != null)
                                    ? Color.fromARGB(255, 70, 70, 70)
                                    : HexColor("#66FF7F"),
                            fontSize: 30.0,
                            fontWeight: FontWeight.w400),
                      ),
                    )),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

double evalExpression(String expression) {
  double result = 10.0;
  return result;
}

String removeLastCharacter(String text) {
  if (text.isNotEmpty) {
    return text.substring(0, text.length - 1);
  }
  return text;
}
