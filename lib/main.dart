import 'dart:math';

import 'package:dices/dice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  await SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Game(),
    );
  }
}

class Game extends StatefulWidget {
  const Game({
    Key key,
  }) : super(key: key);

  @override
  GameState createState() {
    return new GameState();
  }
}

class GameState extends State<Game> {
  // state
  Color currentBackgroundColor;
  int numberOfDices = 1;
  int firstDiceValue;
  int secondDiceValue;
  Random generator;

  static const Duration animationDuration = const Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    generator = Random();
    _regenerateValues();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        setState(() {
          _regenerateValues();
        });
      },
      child: Material(
        child: AnimatedContainer(
          duration: animationDuration,
          color: currentBackgroundColor,
          child: Stack(
            children: [
              _buildDices(context),
              Positioned(
                right: 24,
                top: 24,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      numberOfDices = numberOfDices == 2 ? 1 : 2;
                    });
                  },
                  child: Container(
                    decoration: ShapeDecoration(
                        shape: CircleBorder(
                            side: BorderSide(color: Colors.white, width: 4)),
                        color: numberOfDices == 2
                            ? Colors.white
                            : Colors.transparent),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "2x",
                        style: theme.textTheme.display1.copyWith(
                            fontSize: 32,
                            color: numberOfDices == 2
                                ? currentBackgroundColor
                                : Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _generateValue() => generator.nextInt(5) + 1;

  Color _generateColor() =>
      _backgroundColors[generator.nextInt(_backgroundColors.length)];

  void _regenerateValues() {
    firstDiceValue = _generateValue();
    secondDiceValue = _generateValue();
    Color nextColor = _generateColor();
    while (nextColor == currentBackgroundColor) {
      nextColor = _generateColor();
    }
    currentBackgroundColor = nextColor;
  }

  Widget _buildDices(BuildContext context) {
    if (numberOfDices == 1) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Dice(
            value: firstDiceValue,
            backgroundColor: Colors.transparent,
            primaryColor: Colors.black87,
            animationDuration: animationDuration,
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Dice(
                        value: firstDiceValue,
                        backgroundColor: Colors.transparent,
                        primaryColor: Colors.black87,
                        animationDuration: animationDuration,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Dice(
                        value: secondDiceValue,
                        backgroundColor: Colors.transparent,
                        primaryColor: Colors.black87,
                        animationDuration: animationDuration,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  )
                ],
              ),
            )
          ],
        ),
      );
    }
  }
}

List<Color> _backgroundColors = [
  Colors.green.shade400,
  Colors.redAccent.shade100,
  Colors.orange.shade300,
  Colors.orange.shade50,
  Colors.blue.shade700,
  Colors.cyan,
  Colors.yellow.shade500,
  Colors.indigoAccent.shade400,
  Colors.teal.shade300,
  Colors.brown.shade300,
];
