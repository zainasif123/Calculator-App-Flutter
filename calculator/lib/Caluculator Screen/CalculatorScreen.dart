import 'package:calculator/Constants/Colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  double firstNumber = 0.0;
  double secondNumber = 0.0;
  bool darkColor = false;

  var input = '';
  var output = '0';
  var operation = '';

  void onButtonClicked(value) {
    if (value == "AC") {
      input = '';
      output = '0';
    } else if (value == "<-") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll("x", "*");
        Parser p = Parser();
        Expression exp = p.parse(userInput);
        ContextModel cmd = ContextModel();
        var finalAns = exp.evaluate(EvaluationType.REAL, cmd);
        output = finalAns.toString();
        output = output.substring(0, output.length - 2);
      }
    } else {
      input = input + value;
      debugPrint(input);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: darkColor ? Colors.black : Colors.white,
        body: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  style: ButtonStyle(),
                  onPressed: () {
                    setState(() {
                      darkColor = false;
                    });
                  },
                  child: Icon(
                    Icons.sunny,
                    size: 30,
                    color: darkColor ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      darkColor = true;
                    });
                  },
                  child: Icon(
                    Icons.dark_mode,
                    color: darkColor ? Colors.white : Colors.black,
                    size: 30,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(output,
                          style: TextStyle(
                              fontSize: 52,
                              color: darkColor
                                  ? Colors.white.withOpacity(0.7)
                                  : Colors.black)),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        input,
                        style: TextStyle(
                            fontSize: 48,
                            color: darkColor
                                ? Colors.white.withOpacity(0.7)
                                : Colors.black),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ]),
              ),
            ),
            Row(
              children: [
                button(text: "AC", tColor: orangeColor),
                button(text: "<-", tColor: orangeColor),
                Visibility(
                    visible: false,
                    child: button(text: "", ButtonBGColor: Colors.transparent)),
                button(text: "/", tColor: orangeColor),
              ],
            ),
            Row(
              children: [
                button(text: "7"),
                button(text: "8"),
                button(text: "9"),
                button(text: "x", tColor: orangeColor),
              ],
            ),
            Row(
              children: [
                button(text: "4"),
                button(text: "5"),
                button(text: "6"),
                button(text: "-", tColor: orangeColor),
              ],
            ),
            Row(
              children: [
                button(text: "1"),
                button(text: "2"),
                button(text: "3"),
                button(text: "+", tColor: orangeColor),
              ],
            ),
            Row(
              children: [
                button(text: "%"),
                button(text: "0"),
                button(text: "."),
                button(text: "=", ButtonBGColor: orangeColor),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget button({text, tColor = Colors.white, ButtonBGColor = buttonColor}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              side: BorderSide(color: darkColor ? Colors.white : Colors.black),
              backgroundColor: darkColor ? ButtonBGColor : Colors.white),
          onPressed: () {
            onButtonClicked(text);
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 18,
                  color: darkColor ? tColor : Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
