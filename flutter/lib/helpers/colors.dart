import 'package:flutter/material.dart';

// Harmonized green palette for charts and accents
// A mix of emerald, teal and lime tints to keep multi-series readable
const LIST_OF_COLORS8 = [
  Color(0xFF065F46), // emerald 800
  Color(0xFF047857), // emerald 700
  Color(0xFF059669), // emerald 600
  Color(0xFF10B981), // emerald 500
  Color(0xFF14B8A6), // teal 500
  Color(0xFF22C55E), // emerald 500 bright
  Color(0xFF84CC16), // lime 500
  Color(0xFFA3E635), // lime 400
];

const LIST_OF_COLORS5 = [
  Color(0xFF065F46),
  Color(0xFF059669),
  Color(0xFF10B981),
  Color(0xFF22C55E),
  Color(0xFF84CC16),
];

const LIST_OF_COLORS3 = [
  Color(0xFF059669),
  Color(0xFF10B981),
  Color(0xFF84CC16),
];

const COLOR_SURPLUS = Color.fromARGB(255, 231, 71, 71);

Iterable<Color> generateChartColors(int nrOfItems) sync* {
  final List<Color> colors;

  if (nrOfItems <= 3) {
    colors = LIST_OF_COLORS3;
  } else if (nrOfItems <= 5) {
    colors = LIST_OF_COLORS5;
  } else {
    colors = LIST_OF_COLORS8;
  }

  for (final color in colors) {
    yield color;
  }

  // Always return black after generating nrOfItems colors
  while (true) {
    yield Colors.black;
  }
}
