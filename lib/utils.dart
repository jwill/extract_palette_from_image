import 'package:flutter/material.dart';
import 'dart:ui';

/// Converts a [Color] into a #RRGGBB string.
extension ColorUtils on Color {
  String toRGB() {
    // In the example all alphas are 255, so no need to show it.
    return '#${red.toHex()}${green.toHex()}${blue.toHex()}';
  }
  String toHex() {
    final R = (r * 255).toInt().toRadixString(16).padLeft(2, '0');
    final G = (g * 255).toInt().toRadixString(16).padLeft(2, '0');
    final B = (b * 255).toInt().toRadixString(16).padLeft(2, '0');
    return '#$R$G$B';
  }

  Color onColor() {
    return computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }
}

/// Converts an [int] to a uppercase hexadecimal string of at least [minDigits] length.
extension on int {
  String toHex([int minDigits = 2]) {
    return toRadixString(16).toUpperCase().padLeft(minDigits, '0');
  }
}
