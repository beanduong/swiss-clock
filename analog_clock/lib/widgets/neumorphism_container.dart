import 'package:flutter/material.dart';
import 'package:swiss_clock/widgets/clock_specs.dart';

/// A container with a Neumorphism (2.5D lighting effect) aesthetic,
class NeumorphismContainer extends StatelessWidget {
  NeumorphismContainer({
    this.child,
    this.blurRadius: 20,
    this.offset: const Offset(10, 10),
    this.borderRadius,
    this.padding: const EdgeInsets.all(0),
  });

  /// The [Widget] to render inside of the container.
  final Widget child;

  /// [Offset] of the box shadows.
  ///
  /// Normal values used for highlight and inverted values used for shadows.
  final Offset offset;

  /// Blur radius of the box shadows.
  final double blurRadius;

  /// Border radius of the container.
  final double borderRadius;

  /// Padding of the container.
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: ClockSpecs.of(context).data.backgroundColor,
        borderRadius:
            borderRadius != null ? BorderRadius.circular(borderRadius) : null,
        boxShadow: [
          BoxShadow(
            blurRadius: blurRadius,
            offset: -offset,
            color: ClockSpecs.of(context).data.highlightColor,
          ),
          BoxShadow(
            blurRadius: blurRadius,
            offset: offset,
            color: ClockSpecs.of(context).data.shadowColor,
          )
        ],
      ),
      child: child,
    );
  }
}
