part of '../../error_overlay.dart';

///This is a special widget which will manage monitoring of errors
class ShowErrorOverlay extends StatefulWidget {
  ///the show error overlay button will be placed
  final Widget child;

  ///number of times the user must tap the show error overlay button to enable monitoring
  final int taps;

  ///maximum duration between user taps to enable monitoring
  final Duration maxDurationBetweenTaps;

  ///This is a special widget which will manage monitoring of errors and will control the monitoring of the show error overlay
  const ShowErrorOverlay({
    super.key,
    required this.child,
    this.taps = 5,
    this.maxDurationBetweenTaps = const Duration(milliseconds: 500),
  });

  @override
  State<ShowErrorOverlay> createState() => _ShowErrorOverlayState();
}

class _ShowErrorOverlayState extends State<ShowErrorOverlay> {
  int _userTaps = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: widget.child,
    );
  }

  void _onTap() {
    _userTaps++;
    final currentTaps = _userTaps;
    print("Taps:  $_userTaps");
    if (_userTaps == widget.taps) {
      try {
        context.read<_ErrorOverlayProvider>().toggleMonitor();
      } catch (e) {
        print('Please wrap parent widget with ErrorOverlay');
      }
      _userTaps = 0;
    } else {
      Future.delayed(
        widget.maxDurationBetweenTaps,
        () {
          if (currentTaps == _userTaps) {
            _userTaps = 0;
          }
        },
      );
    }
  }
}
