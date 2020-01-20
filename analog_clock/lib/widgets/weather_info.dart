// Copyright 2020 Chi Khoi Nguyen Duong. All rights reserved.
// Use of this source code is governed by an MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:swiss_clock/widgets/clock_specs.dart';

/// Path for black weather icon assets.
final String weatherIconsBlackPath = 'assets/images/weather_icons_black/';

/// Path for white weather icon assets.
final String weatherIconsWhitePath = 'assets/images/weather_icons_white/';

class WeatherInfo extends StatelessWidget {
  const WeatherInfo({
    key,
    @required this.condition,
    @required this.temperature,
    @required this.temperatureRange,
  }) : super(key: key);

  /// Current weather condition.
  final String condition;

  /// Current temperature.
  final String temperature;

  /// Current temperature range between lowest and highest.
  final String temperatureRange;

  @override
  Widget build(BuildContext context) {
    // Use sunny_night asset (moon) instead of sunny asset (sun) at night.
    final String finalCondition =
        DateTime.now().hour > 19 && condition == 'sunny'
            ? '${condition}_night'
            : condition;
    return DefaultTextStyle(
      style: TextStyle(
          color: ClockSpecs.of(context).data.primaryColor,
          fontFamily: 'GothicA1 Regular'),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset(ClockSpecs.of(context).data.brightness == Brightness.light
              ? '$weatherIconsBlackPath$finalCondition.png'
              : '$weatherIconsWhitePath$finalCondition.png'),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                temperature,
                style: TextStyle(
                    fontSize: ClockSpecs.of(context).data.height * 0.05),
              ),
              Text(
                temperatureRange,
                style: TextStyle(
                    fontSize: ClockSpecs.of(context).data.height * 0.025),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
