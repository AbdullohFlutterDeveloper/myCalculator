import 'package:flutter/material.dart';
import 'package:mycalc/widgets/buttons.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQuestion = "";

  var userAnswer = "";

  final List<String> buttons = [
    "C",
    "DEL",
    "%",
    "/",
    "9",
    "8",
    "7",
    "x",
    "6",
    "5",
    "4",
    "-",
    "3",
    "2",
    "1",
    "+",
    "0",
    ".",
    "ANS",
    "=",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          userQuestion,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          userAnswer,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
            color: Colors.indigo[100],
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemCount: buttons.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            userQuestion = "";
                            userAnswer = "";
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.green,
                        textColor: Colors.white,
                      );
                    } else if (index == 1) {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            userQuestion = userQuestion.substring(
                                0, userQuestion.length - 1);
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.red,
                        textColor: Colors.white,
                      );
                    } else if (index == buttons.length - 1) {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            equalPressed();
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.deepPurple,
                        textColor: Colors.white,
                      );
                    } else {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            userQuestion += buttons[index];
                          });
                        },
                        color: isOperator(buttons[index])
                            ? Colors.deepPurple
                            : Colors.deepPurple[50],
                        textColor: isOperator(buttons[index])
                            ? Colors.white
                            : Colors.deepPurple,
                        buttonText: buttons[index],
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isOperator(String x) {
    if (x == "%" || x == "/" || x == "-" || x == "+" || x == "=" || x == "x") {
      return true;
    } else {
      return false;
    }
  }

  void equalPressed() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', "*");
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer = eval.toString();
  }
}
