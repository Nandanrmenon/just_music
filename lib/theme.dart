import 'package:flutter/material.dart';
import 'package:just_music/constants.dart';

ThemeData themeDark() {
  return ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blue, brightness: Brightness.dark)
        .copyWith(primary: kPrimaryColor, secondary: kAccentColor),
    textTheme: const TextTheme(
      bodyText2: TextStyle(fontSize: 14.0),
    ),
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        fontSize: 20.0,
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
    ),
    cardTheme: CardTheme(
      elevation: 0,
      color: kAccentColor.withAlpha(15),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(kCardBorderRadius))),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    dividerTheme: const DividerThemeData(
      color: Colors.white,
      space: 40,
      indent: 10,
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: kAccentColor,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: Colors.white,
        padding: kButtonPadding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kButtonBorderRadius),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: kAccentColor,
        padding: kButtonPadding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kButtonBorderRadius),
        ),
        elevation: 0,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
      primary: Colors.white,
      side: const BorderSide(color: kAccentColor),
      padding: kButtonPadding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kButtonBorderRadius),
      ),
    )),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kInputDecorationBorderRadius),
        borderSide: const BorderSide(width: 0.5, color: kBorderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kInputDecorationBorderRadius),
        borderSide: const BorderSide(width: 0.5, color: kAccentColor),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kInputDecorationBorderRadius),
        borderSide: const BorderSide(width: 0.5, color: kBorderColor),
      ),
      prefixIconColor: kAccentColor,
      suffixIconColor: kAccentColor,
      floatingLabelStyle: const TextStyle(color: kAccentColor),
      filled: true,
      contentPadding: kInputDecorationPadding,
      isDense: true,
    ),
    drawerTheme: DrawerThemeData(backgroundColor: Colors.grey.shade800),
    bottomSheetTheme:
        const BottomSheetThemeData(backgroundColor: Colors.transparent),
    popupMenuTheme: PopupMenuThemeData(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0))),
    listTileTheme: const ListTileThemeData(
      selectedColor: kAccentColor,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: kAccentColor,
    ),
  );
}
