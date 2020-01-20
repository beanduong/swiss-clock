// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:swiss_clock/widgets/analog_clock.dart';
import 'package:swiss_clock/widgets/clock_specs.dart';
import 'package:swiss_clock/widgets/date_info.dart';
import 'package:swiss_clock/widgets/clock_marks.dart';
import 'package:swiss_clock/widgets/neumorphism_container.dart';
import 'package:swiss_clock/widgets/weather_info.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';

/// A swiss analog clock.
class SwissClock extends StatefulWidget {
  const SwissClock(this.model);

  /// [ClockModel] to receive location, weather and temperature information.
  final ClockModel model;

  @override
  _SwissClockState createState() => _SwissClockState();
}

class _SwissClockState extends State<SwissClock> {
  /// Current [DateTime].
  DateTime _now = DateTime.now();

  /// Current temperature.
  String _temperature = '';

  /// Current range of temperature between lowest and highest.
  String _temperatureRange = '';

  /// Current weather condition.
  String _condition = '';

  @override
  void initState() {
    super.initState();
    // Listen to model changes.
    widget.model.addListener(_updateModel);
    // Set the initial values.
    _updateModel();
  }

  @override
  void didUpdateWidget(SwissClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    widget.model.removeListener(_updateModel);
    super.dispose();
  }

  /// Update method for retreiving new model information.
  void _updateModel() {
    setState(() {
      _temperature = widget.model.temperatureString;
      _temperatureRange =
          '${widget.model.lowString} / ${widget.model.highString}';
      _condition = widget.model.weatherString;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ClockSpecs.of(context).data.backgroundColor,
      padding: EdgeInsets.all(ClockSpecs.of(context).data.height * 0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 54,
            child: AspectRatio(
              aspectRatio: 1,
              child: NeumorphismContainer(
                borderRadius: 1000,
                child: Stack(
                  children: [
                    // Clock that periodically re-renders
                    AnalogClock(
                      updateInterval: 200,
                    ),
                    // Clock decorations which don't need to be re-rendered
                    //
                    // Clock marks
                    DrawnClockmarks(
                      start: 0.85,
                      end: 0.96,
                      count: 12,
                      thickness: ClockSpecs.of(context).data.height * 0.005,
                    ),
                    // Central clock hands piece
                    Container(
                      child: Center(
                        child: Container(
                          width: ClockSpecs.of(context).data.height * 0.0325,
                          height: ClockSpecs.of(context).data.height * 0.0325,
                          decoration: BoxDecoration(
                            color: ClockSpecs.of(context).data.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Spacer(
            flex: 9,
          ),
          Expanded(
            flex: 37,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Weather info widget
                Expanded(
                  flex: 22,
                  child: NeumorphismContainer(
                    borderRadius: 10,
                    padding: EdgeInsets.all(
                        ClockSpecs.of(context).data.height * 0.04),
                    child: AnimatedSwitcher(
                      duration: Duration(seconds: 1),
                      child: WeatherInfo(
                        key: ValueKey<String>(
                            '$_condition$_temperature}$_temperatureRange'),
                        condition: _condition,
                        temperature: _temperature,
                        temperatureRange: _temperatureRange,
                      ),
                    ),
                  ),
                ),
                Spacer(flex: 13),
                // Date info widget
                Expanded(
                  flex: 64,
                  child: NeumorphismContainer(
                    borderRadius: 10,
                    padding: EdgeInsets.all(
                        ClockSpecs.of(context).data.height * 0.025),
                    child: AnimatedSwitcher(
                      duration: Duration(seconds: 1),
                      child: DateInfo(
                        key: ValueKey<int>(_now.day),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
