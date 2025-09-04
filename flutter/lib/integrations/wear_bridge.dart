import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/routines.dart';

class WearBridge {
  static final WearBridge _instance = WearBridge._internal();
  factory WearBridge() => _instance;
  WearBridge._internal();

  final _logger = Logger('WearBridge');
  static const _channel = MethodChannel('wger/wear');
  bool _inited = false;

  Future<void> init(AuthProvider auth, RoutinesProvider routines) async {
    if (_inited) return;
    try {
      await _channel.invokeMethod('initWear');
      _inited = true;
      _logger.info('Wear bridge initialized');
      _channel.setMethodCallHandler((call) async {
        if (call.method == 'onSessionChanged') {
          _logger.info('Wear: session changed, refreshing');
          try {
            await routines.fetchAndSetAllRoutinesFull();
          } catch (e) {
            _logger.warning('Refresh after session change failed: $e');
          }
        }
      });
    } catch (e) {
      _logger.warning('Wear init failed: $e');
    }
  }

  Future<void> sendAuth(AuthProvider auth) async {
    if (!_inited || !auth.isAuth) return;
    try {
      await _channel.invokeMethod('sendAuth', {
        'serverUrl': auth.serverUrl,
        'token': auth.token,
      });
    } catch (e) {
      _logger.warning('sendAuth failed: $e');
    }
  }

  Future<void> sendLogout() async {
    if (!_inited) return;
    try {
      await _channel.invokeMethod('sendLogout');
    } catch (e) {
      _logger.warning('sendLogout failed: $e');
    }
  }

  Future<void> sendSessionChanged() async {
    if (!_inited) return;
    try {
      await _channel.invokeMethod('sendSessionChanged');
    } catch (e) {
      _logger.warning('sendSessionChanged failed: $e');
    }
  }
}
