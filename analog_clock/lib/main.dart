// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/customizer.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:swiss_clock/widgets/clock_specs.dart';
import 'package:swiss_clock/widgets/swiss_clock.dart';

void main() {
  // A temporary measure until Platform supports web and TargetPlatform supports
  // macOS.
  if (!kIsWeb && Platform.isMacOS) {
    // TODO(gspencergoog): Update this when TargetPlatform includes macOS.
    // https://github.com/flutter/flutter/issues/31366
    // See https://github.com/flutter/flutter/wiki/Desktop-shells#target-platform-override.
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }

  // This creates a clock that enables you to customize it.
  //
  // The [ClockCustomizer] takes in a [ClockBuilder] that consists of:
  //  - A clock widget (in this case, [AnalogClock])
  //  - A model (provided to you by [ClockModel])
  // For more information, see the flutter_clock_helper package.
  //
  // Your job is to edit [AnalogClock], or replace it with your own clock
  // widget. (Look in analog_clock.dart for more details!)
  runApp(
    ClockCustomizer(
      (ClockModel model) => LayoutBuilder(
        builder: (context, constraints) => ClockSpecs(
            data: Theme.of(context).brightness == Brightness.light
                // Light theme.
                ? ClockSpecsData(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    primaryColor: Color(0xFF000000),
                    backgroundColor: Color(0xFFF5F4F4),
                    highlightColor: Color(0xFFFFFFFF),
                    shadowColor: Color(0x19000000),
                    brightness: Theme.of(context).brightness,
                  )
                // Dark theme
                : ClockSpecsData(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    primaryColor: Color(0xFFFFFFFF),
                    backgroundColor: Color(0xFF0D1014),
                    highlightColor: Color(0x03FFFFFF),
                    shadowColor: Color(0x40000000),
                    brightness: Theme.of(context).brightness,
                  ),
            child: SwissClock(model)),
      ),
    ),
  );
}
