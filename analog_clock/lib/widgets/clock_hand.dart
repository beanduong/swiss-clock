// Copyright 2020 Chi Khoi Nguyen Duong. All rights reserved.
// Use of this source code is governed by an MIT license that can be
// found in the LICENSE file.

import 'dart:math' as math;

import 'package:flutter/material.dart';

/// A clock hand that is drawn with [CustomPainter]
///
/// The hand's length scales based on the clock's size.
/// This hand is used to build the second and minute hands, and demonstrates
/// building a custom hand.
class ClockHand extends StatelessWidget {
  /// Create a const clock [Hand].
  ///
  /// All of the parameters are required and must not be null.
  const ClockHand({
    @required this.thickness,
    @required this.overShootSize,
    @required this.size,
    @required this.color,
    @required this.angleRadians,
  })  : assert(thickness != null),
        assert(overShootSize != null),
        assert(color != null),
        assert(size != null),
        assert(angleRadians != null);

  /// How thick the hand should be drawn, in logical pixels.
  final double thickness;

  /// How far the hand should overshoot on the other side as a
  /// percentage of the smaller side of the clock's parent container.
  final double overShootSize;

  /// The color of the hand.
  final Color color;

  /// Hand length, as a percentage of the smaller side of the clock's parent
  /// container.
  final double size;

  /// The angle, in radians, at which the hand is drawn.
  ///
  /// This angle is measured from the 12 o'clock position.
  final double angleRadians;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.expand(
        child: CustomPaint(
          painter: _HandPainter(
            lineWidth: thickness,
            overShootSize: overShootSize,
            color: color,
            handSize: size,
            angleRadians: angleRadians,
          ),
        ),
      ),
    );
  }
}

/// [CustomPainter] that draws a clock hand.
///
class _HandPainter extends CustomPainter {
  _HandPainter({
    @required this.overShootSize,
    @required this.handSize,
    @required this.lineWidth,
    @required this.angleRadians,
    @required this.color,
  })  : assert(handSize != null),
        assert(overShootSize != null),
        assert(lineWidth != null),
        assert(angleRadians != null),
        assert(color != null),
        assert(overShootSize >= 0.0),
        assert(overShootSize <= 1.0),
        assert(handSize >= 0.0),
        assert(handSize <= 1.0);
  final double lineWidth;
  final double overShootSize;
  final double handSize;
  final Color color;
  final double angleRadians;

  @override
  void paint(Canvas canvas, Size size) {
    final center = (Offset.zero & size).center;
    // We want to start at the top, not at the x-axis, so add pi/2.
    final angle = angleRadians - math.pi / 2.0;
    final length = size.shortestSide * 0.5 * handSize;
    final overShootLength = size.shortestSide * 0.5 * overShootSize;
    final position = center + Offset(math.cos(angle), math.sin(angle)) * length;
    final overShootPosition =
        center + Offset(-math.cos(angle), -math.sin(angle)) * overShootLength;
    final linePaint = Paint()
      ..color = color
      ..strokeWidth = lineWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(center, position, linePaint);
    canvas.drawLine(center, overShootPosition, linePaint);
  }

  @override
  bool shouldRepaint(_HandPainter oldDelegate) {
    return oldDelegate.lineWidth != lineWidth ||
        oldDelegate.overShootSize != overShootSize ||
        oldDelegate.handSize != handSize ||
        oldDelegate.color != color ||
        oldDelegate.angleRadians != angleRadians;
  }
}
