import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class _RwMaterialLocalizationsDelegate extends LocalizationsDelegate<MaterialLocalizations> {
  const _RwMaterialLocalizationsDelegate();
  @override
  bool isSupported(Locale locale) => locale.languageCode == 'rw';
  @override
  Future<MaterialLocalizations> load(Locale locale) async => const DefaultMaterialLocalizations();
  @override
  bool shouldReload(covariant LocalizationsDelegate<MaterialLocalizations> old) => false;
}

class _RwWidgetsLocalizationsDelegate extends LocalizationsDelegate<WidgetsLocalizations> {
  const _RwWidgetsLocalizationsDelegate();
  @override
  bool isSupported(Locale locale) => locale.languageCode == 'rw';
  @override
  Future<WidgetsLocalizations> load(Locale locale) async => const DefaultWidgetsLocalizations();
  @override
  bool shouldReload(covariant LocalizationsDelegate<WidgetsLocalizations> old) => false;
}

class _RwCupertinoLocalizationsDelegate extends LocalizationsDelegate<CupertinoLocalizations> {
  const _RwCupertinoLocalizationsDelegate();
  @override
  bool isSupported(Locale locale) => locale.languageCode == 'rw';
  @override
  Future<CupertinoLocalizations> load(Locale locale) {
    return SynchronousFuture<CupertinoLocalizations>(const DefaultCupertinoLocalizations());
  }
  @override
  bool shouldReload(covariant LocalizationsDelegate<CupertinoLocalizations> old) => false;
}

const LocalizationsDelegate<MaterialLocalizations> rwMaterialLocalizationDelegate = _RwMaterialLocalizationsDelegate();
const LocalizationsDelegate<WidgetsLocalizations> rwWidgetsLocalizationDelegate = _RwWidgetsLocalizationsDelegate();
const LocalizationsDelegate<CupertinoLocalizations> rwCupertinoLocalizationDelegate = _RwCupertinoLocalizationsDelegate();

