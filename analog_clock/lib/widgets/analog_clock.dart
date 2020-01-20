// Copyright 2020 Chi Khoi Nguyen Duong. All rights reserved.
// Use of this source code is governed by an MIT license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:swiss_clock/widgets/clock_hand.dart';
import 'package:swiss_clock/widgets/clock_specs.dart';
import 'package:vector_math/vector_math_64.dart' show radians;

/// Total distance traveled by an hour hand, each hour, in radians.
final radiansPerHour = radians(360 / 12);

/// Total distance traveled by a second or a minute hand, each second or minute,
/// respectively.
final radiansPerTick = radians(360 / 60);

/// A basic analog clock.
class AnalogClock extends StatefulWidget {
  /// The interval in which the clock should update.
  final int updateInterval;

  const AnalogClock({this.updateInterval});

  @override
  _AnalogClockState createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock> {
  /// Current [DateTime].
  DateTime _now = DateTime.now();

  /// [Timer] for updating the clock.
  Timer _timer;

  @override
  void initState() {
    super.initState();
    // Update in a given interval. Round to the nearest interval
    // multiple to eliminate timing inaccuracies.
    _timer = Timer.periodic(Duration(milliseconds: widget.updateInterval), (v) {
      setState(() {
        _now = DateTime.now().subtract(Duration(
            milliseconds: DateTime.now().millisecond % widget.updateInterval));
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Seconds hand.
        ClockHand(
          color: ClockSpecs.of(context).data.primaryColor,
          thickness: ClockSpecs.of(context).data.height * 0.005,
          size: 0.9,
          overShootSize: 0.1,
          angleRadians:
              (_now.second + _now.millisecond / 1000) * radiansPerTick,
        ),
        // Minutes hand.
        ClockHand(
          color: ClockSpecs.of(context).data.primaryColor,
          thickness: ClockSpecs.of(context).data.height * 0.0075,
          size: 0.75,
          overShootSize: 0,
          angleRadians: (_now.minute + _now.second / 60) * radiansPerTick,
        ),
        // Hours hand.
        ClockHand(
          color: ClockSpecs.of(context).data.primaryColor,
          thickness: ClockSpecs.of(context).data.height * 0.0125,
          size: 0.575,
          overShootSize: 0,
          angleRadians: (_now.hour + _now.minute / 60) * radiansPerHour,
        ),
      ],
    );
  }
}
