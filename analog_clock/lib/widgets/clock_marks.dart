// Copyright 2020 Chi Khoi Nguyen Duong. All rights reserved.
// Use of this source code is governed by an MIT license that can be
// found in the LICENSE file.

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:swiss_clock/widgets/clock_specs.dart';
import 'package:vector_math/vector_math_64.dart' show radians;

/// Clock mark decorations that are drawn with [CustomPainter]
class DrawnClockmarks extends StatelessWidget {
  const DrawnClockmarks({
    @required this.start,
    @required this.end,
    @required this.count,
    @required this.thickness,
  })  : assert(start != null),
        assert(end != null),
        assert(count != null),
        assert(thickness != null);

  /// Start point of marks as a percentage of the smaller
  /// side of the clock's parent container.
  final double start;

  /// End point of marks as a percentage of the smaller
  /// side of the clock's parent container.
  final double end;

  /// Number of clock marks to draw
  final int count;

  /// How thick the mark should be drawn, in logical pixels.
  final double thickness;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.expand(
        child: CustomPaint(
          painter: _DrawnClockMarksPainter(
            start: start,
            end: end,
            count: count,
            color: ClockSpecs.of(context).data.primaryColor,
            lineWidth: thickness,
          ),
        ),
      ),
    );
  }
}

/// [CustomPainter] that draws clock hour marks.
class _DrawnClockMarksPainter extends CustomPainter {
  const _DrawnClockMarksPainter({
    @required this.start,
    @required this.end,
    @required this.count,
    @required this.lineWidth,
    @required this.color,
  })  : assert(start != null),
        assert(end != null),
        assert(count != null),
        assert(lineWidth != null),
        assert(color != null),
        assert(start >= 0.0),
        assert(start <= 1.0),
        assert(end >= 0.0),
        assert(end <= 1.0);
  final double start;
  final double end;
  final int count;
  final double lineWidth;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = (Offset.zero & size).center;
    final double radius = size.shortestSide * 0.5;
    final double angleRadians = radians(360 / count);

    final Paint linePaint = Paint()
      ..color = color
      ..strokeWidth = lineWidth
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < count; i++) {
      final double angle = angleRadians * i;
      final Offset startPos =
          center + Offset(math.cos(angle), math.sin(angle)) * start * radius;
      final Offset endPos =
          center + Offset(math.cos(angle), math.sin(angle)) * end * radius;
      canvas.drawLine(startPos, endPos, linePaint);
    }
  }

  @override
  bool shouldRepaint(_DrawnClockMarksPainter oldDelegate) {
    return oldDelegate.start != start ||
        oldDelegate.end != end ||
        oldDelegate.color != color ||
        oldDelegate.count != count ||
        oldDelegate.lineWidth != lineWidth;
  }
}
