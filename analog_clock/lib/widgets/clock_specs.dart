import 'package:flutter/material.dart';

/// [InheritedWidget]  to get the clock face dimensions and colors.
///
/// Because the target device and window aspect ratio are
/// pre-defined, we can size our UI elements by percentages
/// based on the window height.
class ClockSpecs extends InheritedWidget {
  ClockSpecs({
    Key key,
    @required Widget child,
    @required this.data,
  })  : assert(child != null),
        assert(data != null),
        super(key: key, child: child);

  /// Data that contains the clocks specifications.
  final ClockSpecsData data;

  static ClockSpecs of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ClockSpecs>();
  }

  @override
  bool updateShouldNotify(ClockSpecs oldWidget) {
    return oldWidget.data != data;
  }
}

/// Data model for defining the spec types.
class ClockSpecsData {
  ClockSpecsData({
    @required this.width,
    @required this.height,
    @required this.primaryColor,
    @required this.backgroundColor,
    @required this.highlightColor,
    @required this.shadowColor,
    @required this.brightness,
  })  : assert(width != null),
        assert(height != null),
        assert(primaryColor != null),
        assert(backgroundColor != null),
        assert(highlightColor != null),
        assert(shadowColor != null),
        assert(brightness != null);

  /// Width of the available space to draw the clock.
  final double width;

  /// Height of the available space to draw the clock.
  final double height;

  /// Color that contrasts with the background color.
  final Color primaryColor;

  /// Color that contrasts with the primary color.
  final Color backgroundColor;

  /// Color for Neumorphism light effect.
  final Color highlightColor;

  /// Color for Neumorphism shadow effect.
  final Color shadowColor;

  /// Current brightness of the app.
  final Brightness brightness;
}
