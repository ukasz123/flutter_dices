import 'package:flutter/material.dart';

class Dice extends StatelessWidget {
  final int value;
  final Duration animationDuration;

  final Color primaryColor;
  Color backgroundColor;

  Dice({
    Key key,
    @required this.value,
    this.animationDuration = const Duration(
      milliseconds: 200,
    ),
    this.primaryColor = Colors.black87,
    this.backgroundColor,
  }) : super(key: key) {
    backgroundColor ??= this.primaryColor.withOpacity(0.37);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      child: LayoutBuilder(
        builder: (context, BoxConstraints constraints) {
          final side = constraints.biggest.shortestSide;
          final border = side * 0.08;
          final dotSide = (side - 2 * border) / 3;
          return Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: side, maxHeight: side),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(border),
                  side: BorderSide(
                    color: primaryColor,
                    width: border / 2,
                  ),
                ),
                color: backgroundColor,
              ),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: AnimatedOpacity(
                      child: Dot(
                        dotSide: dotSide,
                        color: primaryColor,
                      ),
                      opacity: value.isOdd ? 1 : 0,
                      duration: animationDuration,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: AnimatedOpacity(
                      opacity: value > 3 ? 1 : 0,
                      duration: animationDuration,
                      child: Dot(
                        dotSide: dotSide,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: AnimatedOpacity(
                      opacity: value > 1 ? 1 : 0,
                      duration: animationDuration,
                      child: Dot(
                        dotSide: dotSide,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: AnimatedOpacity(
                      opacity: value > 1 ? 1 : 0,
                      duration: animationDuration,
                      child: Dot(
                        dotSide: dotSide,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: AnimatedOpacity(
                      opacity: value > 3 ? 1 : 0,
                      duration: animationDuration,
                      child: Dot(
                        dotSide: dotSide,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AnimatedOpacity(
                      opacity: value == 6 ? 1 : 0,
                      duration: animationDuration,
                      child: Dot(
                        dotSide: dotSide,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: AnimatedOpacity(
                      opacity: value == 6 ? 1 : 0,
                      duration: animationDuration,
                      child: Dot(
                        dotSide: dotSide,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      aspectRatio: 1,
    );
  }
}

class Dot extends StatelessWidget {
  final Color color;

  const Dot({
    Key key,
    @required this.dotSide,
    this.color = Colors.black,
  }) : super(key: key);

  final double dotSide;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: dotSide,
      height: dotSide,
      child: FractionallySizedBox(
        widthFactor: 0.75,
        heightFactor: 0.75,
        child: Container(
          decoration: ShapeDecoration(
            color: color,
            shape: CircleBorder(),
          ),
        ),
      ),
    );
  }
}
