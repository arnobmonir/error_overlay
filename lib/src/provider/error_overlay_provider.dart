import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorOverlayProvider with ChangeNotifier {
  bool isEnabled = false;
  LogMonitorMode mode = LogMonitorMode.visible;
  List<FlutterErrorDetails> errors = [];
  void toggleMonitor() {
    isEnabled = !isEnabled;
    notifyListeners();
  }

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
}

enum LogMonitorMode {
  visible,
  dim,
  hide,
}
