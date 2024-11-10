part of '../../error_overlay.dart';

class ShowErrorOverlay extends StatefulWidget {
  final Widget child;
  final int taps;
  final Duration maxDurationBetweenTaps;

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
        context.read<ErrorOverlayProvider>().toggleMonitor();
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
