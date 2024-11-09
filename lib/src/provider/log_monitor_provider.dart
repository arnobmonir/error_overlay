import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogMonitorProvider with ChangeNotifier {
  LogMonitorMode mode = LogMonitorMode.visible;
  DateTime visibleDuration =
      DateTime.now().add(const Duration(seconds: 5)); // 5 seconds
  List<FlutterErrorDetails> errors = [];
  void addError(FlutterErrorDetails error) {
    if (errors.length >= 10) {
      errors.removeAt(0);
    }
    errors.add(error);
    notifyListeners();
  }

  void changeVisibility({LogMonitorMode? modeStatus}) {
    if (modeStatus != null) {
      mode = modeStatus;
    } else {
      if (mode == LogMonitorMode.visible) {
        mode = LogMonitorMode.dim;
      } else if (mode == LogMonitorMode.dim) {
        mode = LogMonitorMode.hide;
      } else {
        mode = LogMonitorMode.visible;
      }
    }

    notifyListeners();
  }

  void updateVisible(int duration) {
    visibleDuration = DateTime.now().add(const Duration(seconds: 5));
    notifyListeners();
  }
}

enum LogMonitorMode {
  visible,
  dim,
  hide,
}
