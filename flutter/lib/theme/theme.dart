/*
 * This file is part of wger Workout Manager <https://github.com/wger-project>.
 * Copyright (C) 2020, 2021 wger Team
 *
 * wger Workout Manager is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * wger Workout Manager is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

// Color scheme, please consult
// * https://pub.dev/packages/flex_color_scheme
// * https://rydmike.com/flexseedscheme/demo-v1/#/

// Brand palette: Green-forward theme
// Primary: emerald 600, Secondary: lime/emerald accent, Tertiary: teal
const Color wgerPrimaryColor = Color(0xFF16A34A); // Emerald 600
const Color wgerPrimaryButtonColor = Color(0xFF22C55E); // Emerald 500
const Color wgerPrimaryColorLight = Color(0xFFA7F3D0); // Emerald 200
const Color wgerSecondaryColor = Color(0xFF84CC16); // Lime 500
const Color wgerSecondaryColorLight = Color(0xFFD9F99D); // Lime 200
const Color wgerTertiaryColor = Color(0xFF10B981); // Teal/Emerald 500

const FlexSubThemesData wgerSubThemeData = FlexSubThemesData(
  fabSchemeColor: SchemeColor.secondary,
  inputDecoratorBorderType: FlexInputBorderType.underline,
  inputDecoratorIsFilled: false,
  useMaterial3Typography: true,
  appBarScrolledUnderElevation: 4,
  navigationBarIndicatorOpacity: 0.28,
  navigationBarHeight: 60,
  // Softer, consistent rounding across components
  defaultRadius: 14,
  elevatedButtonRadius: 16,
  filledButtonRadius: 16,
  outlinedButtonRadius: 16,
  cardRadius: 16,
  dialogRadius: 20,
  bottomSheetRadius: 20,
);

const String wgerDisplayFont = 'RobotoCondensed';
const List<FontVariation> displayFontBoldWeight = [FontVariation('wght', 600)];
const List<FontVariation> displayFontHeavyWeight = [FontVariation('wght', 800)];

// Make a light ColorScheme from the seeds.
final ColorScheme schemeLight = SeedColorScheme.fromSeeds(
  primary: wgerPrimaryColor,
  primaryKey: wgerPrimaryColor,
  secondaryKey: wgerSecondaryColor,
  secondary: wgerSecondaryColor,
  tertiaryKey: wgerTertiaryColor,
  brightness: Brightness.light,
  tones: FlexTones.vivid(Brightness.light),
);

// Make a dark ColorScheme from the seeds.
final ColorScheme schemeDark = SeedColorScheme.fromSeeds(
  // primary: wgerPrimaryColor,
  primaryKey: wgerPrimaryColor,
  secondaryKey: wgerSecondaryColor,
  secondary: wgerSecondaryColor,
  brightness: Brightness.dark,
  tones: FlexTones.vivid(Brightness.dark),
);

// Make a high contrast light ColorScheme from the seeds
final ColorScheme schemeLightHc = SeedColorScheme.fromSeeds(
  primaryKey: wgerPrimaryColor,
  secondaryKey: wgerSecondaryColor,
  brightness: Brightness.light,
  tones: FlexTones.ultraContrast(Brightness.light),
);

// Make a ultra contrast dark ColorScheme from the seeds.
final ColorScheme schemeDarkHc = SeedColorScheme.fromSeeds(
  primaryKey: wgerPrimaryColor,
  secondaryKey: wgerSecondaryColor,
  brightness: Brightness.dark,
  tones: FlexTones.ultraContrast(Brightness.dark),
);

const wgerTextTheme = TextTheme(
  displayLarge: TextStyle(
    fontFamily: wgerDisplayFont,
    fontVariations: displayFontHeavyWeight,
  ),
  displayMedium: TextStyle(
    fontFamily: wgerDisplayFont,
    fontVariations: displayFontHeavyWeight,
  ),
  displaySmall: TextStyle(
    fontFamily: wgerDisplayFont,
    fontVariations: displayFontHeavyWeight,
  ),
  headlineLarge: TextStyle(
    fontFamily: wgerDisplayFont,
    fontVariations: displayFontBoldWeight,
  ),
  headlineMedium: TextStyle(
    fontFamily: wgerDisplayFont,
    fontVariations: displayFontBoldWeight,
  ),
  headlineSmall: TextStyle(
    fontFamily: wgerDisplayFont,
    fontVariations: displayFontBoldWeight,
  ),
  titleLarge: TextStyle(
    fontFamily: wgerDisplayFont,
    fontVariations: displayFontBoldWeight,
  ),
  titleMedium: TextStyle(
    fontFamily: wgerDisplayFont,
    fontVariations: displayFontBoldWeight,
  ),
  titleSmall: TextStyle(
    fontFamily: wgerDisplayFont,
    fontVariations: displayFontBoldWeight,
  ),
);

final wgerLightTheme = FlexThemeData.light(
  colorScheme: schemeLight,
  useMaterial3: true,
  appBarStyle: FlexAppBarStyle.primary,
  subThemesData: wgerSubThemeData,
  textTheme: wgerTextTheme,
).copyWith(
  appBarTheme: const AppBarTheme(
    foregroundColor: Colors.white,
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      minimumSize: const Size(0, 48),
      textStyle: const TextStyle(fontWeight: FontWeight.w700),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(0, 48),
      textStyle: const TextStyle(fontWeight: FontWeight.w700),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      minimumSize: const Size(0, 48),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  ),
  navigationBarTheme: NavigationBarThemeData(
    height: 60,
    indicatorColor: wgerPrimaryButtonColor.withOpacity(0.18),
    labelTextStyle: MaterialStateProperty.resolveWith(
      (states) => TextStyle(
        fontWeight: FontWeight.w600,
        color: states.contains(MaterialState.selected) ? wgerPrimaryColor : Colors.white70,
      ),
    ),
    iconTheme: MaterialStateProperty.resolveWith(
      (states) => IconThemeData(
        size: 22,
        color: states.contains(MaterialState.selected) ? wgerPrimaryColor : Colors.white70,
      ),
    ),
  ),
  cardTheme: CardThemeData(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
  dividerTheme: const DividerThemeData(thickness: .6, space: 16),
  iconTheme: const IconThemeData(size: 22),
);

final wgerDarkTheme = FlexThemeData.dark(
  colorScheme: schemeDark,
  useMaterial3: true,
  subThemesData: wgerSubThemeData,
  textTheme: wgerTextTheme,
).copyWith(
  appBarTheme: const AppBarTheme(
    foregroundColor: Colors.white,
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      minimumSize: const Size(0, 48),
      textStyle: const TextStyle(fontWeight: FontWeight.w700),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(0, 48),
      textStyle: const TextStyle(fontWeight: FontWeight.w700),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      minimumSize: const Size(0, 48),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  ),
  navigationBarTheme: NavigationBarThemeData(
    height: 60,
    indicatorColor: wgerPrimaryButtonColor.withOpacity(0.28),
    labelTextStyle: MaterialStateProperty.resolveWith(
      (states) => TextStyle(
        fontWeight: FontWeight.w600,
        color: states.contains(MaterialState.selected) ? wgerPrimaryColor : Colors.white70,
      ),
    ),
    iconTheme: MaterialStateProperty.resolveWith(
      (states) => IconThemeData(
        size: 22,
        color: states.contains(MaterialState.selected) ? wgerPrimaryColor : Colors.white70,
      ),
    ),
  ),
  cardTheme: CardThemeData(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
  dividerTheme: const DividerThemeData(thickness: .6, space: 16),
  iconTheme: const IconThemeData(size: 22),
);

final wgerLightThemeHc = FlexThemeData.light(
  colorScheme: schemeLightHc,
  useMaterial3: true,
  appBarStyle: FlexAppBarStyle.primary,
  subThemesData: wgerSubThemeData,
  textTheme: wgerTextTheme,
).copyWith(
  appBarTheme: const AppBarTheme(
    foregroundColor: Colors.white,
  ),
  cardTheme: CardThemeData(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
  iconTheme: const IconThemeData(size: 22),
);

final wgerDarkThemeHc = FlexThemeData.dark(
  colorScheme: schemeDarkHc,
  useMaterial3: true,
  subThemesData: wgerSubThemeData,
  textTheme: wgerTextTheme,
).copyWith(
  appBarTheme: const AppBarTheme(
    foregroundColor: Colors.white,
  ),
  cardTheme: CardThemeData(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
  iconTheme: const IconThemeData(size: 22),
);

CalendarStyle getWgerCalendarStyle(ThemeData theme) {
  return CalendarStyle(
    outsideDaysVisible: false,
    todayDecoration: const BoxDecoration(
      // Subtle highlight for 'today'
      color: wgerPrimaryColorLight,
      shape: BoxShape.circle,
    ),
    markerDecoration: BoxDecoration(
      color: theme.textTheme.headlineLarge?.color,
      shape: BoxShape.circle,
    ),
    selectedDecoration: const BoxDecoration(
      color: wgerSecondaryColor,
      shape: BoxShape.circle,
    ),
    rangeStartDecoration: const BoxDecoration(
      color: wgerSecondaryColor,
      shape: BoxShape.circle,
    ),
    rangeEndDecoration: const BoxDecoration(
      color: wgerSecondaryColor,
      shape: BoxShape.circle,
    ),
    rangeHighlightColor: wgerSecondaryColorLight,
    weekendTextStyle: const TextStyle(color: wgerPrimaryColor),
  );
}
