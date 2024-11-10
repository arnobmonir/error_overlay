part of '../../error_overlay.dart';

class _ErrorOverlayProvider with ChangeNotifier {
  bool isEnabled = false;
  _LogMonitorMode mode = _LogMonitorMode.visible;
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

  void changeVisibility({_LogMonitorMode? modeStatus}) {
    if (modeStatus != null) {
      mode = modeStatus;
    } else {
      if (mode == _LogMonitorMode.visible) {
        mode = _LogMonitorMode.dim;
      } else if (mode == _LogMonitorMode.dim) {
        mode = _LogMonitorMode.hide;
      } else {
        mode = _LogMonitorMode.visible;
      }
    }

    notifyListeners();
  }
}

enum _LogMonitorMode {
  visible,
  dim,
  hide,
}
