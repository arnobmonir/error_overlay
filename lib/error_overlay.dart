library;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
part 'src/widgets/show_error_overlay.dart';
part 'src/provider/error_overlay_provider.dart';

///Error overlay widget is create a new error overlay in all the pages that can show the error
class ErrorOverlay extends StatefulWidget {
  /// error overlay will be displayed over the child
  final Widget child;

  /// The Error Overlay  allows you to easily display real-time error logs as an overlay across all pages of your app. This is extremely useful for developers to monitor and debug issues while building and testing the app..
  const ErrorOverlay({
    super.key,
    required this.child,
  });

  @override
  State<ErrorOverlay> createState() => _ErrorOverlayState();
}

class _ErrorOverlayState extends State<ErrorOverlay> {
  Offset _position = const Offset(20, 100);
  Size screenSize = const Size(320, 480);
  final StreamController<FlutterErrorDetails> _streamController =
      StreamController<FlutterErrorDetails>.broadcast();

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context) => _ErrorOverlayProvider(),
      child: Consumer<_ErrorOverlayProvider>(
        builder: (context, provider, providerChild) {
          FlutterError.onError = (FlutterErrorDetails details) {
            FlutterError.presentError(
                details); // This will print the error to the console
            if (provider.isEnabled) {
              _streamController.sink.add(details);
            }
          };
          return provider.isEnabled
              ? Stack(
                  children: [
                    Positioned.fill(
                      child: widget.child,
                    ),
                    Positioned(
                      left: _position.dx,
                      top: _position.dy,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Toggle visibility
                              provider.changeVisibility();
                              // Future.delayed(const Duration(seconds: 1),() {
                              //   provider.toggleVisibility();
                              // },);
                            },
                            onPanUpdate: (details) {
                              setState(() {
                                // Update position while dragging
                                if (_position.dx < 30) {
                                  _position = Offset(30, _position.dy);
                                } else if (_position.dx >
                                    (screenSize.width - 30)) {
                                  _position = Offset(
                                      screenSize.width - 30, _position.dy);
                                } else if (_position.dy < 30) {
                                  _position = Offset(_position.dx, 30);
                                } else if (_position.dy >
                                    (screenSize.height - 30)) {
                                  _position = Offset(
                                      _position.dx, screenSize.height - 30);
                                } else {
                                  _position += details.delta;
                                }
                              });
                            },
                            child: AnimatedOpacity(
                              opacity: provider.mode == _LogMonitorMode.visible
                                  ? 1.0
                                  : 0.5,
                              duration: const Duration(milliseconds: 100),
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue,
                                ),
                                child: Icon(
                                    provider.mode == _LogMonitorMode.hide
                                        ? Icons.vertical_align_bottom
                                        : (provider.mode == _LogMonitorMode.dim
                                            ? Icons.close
                                            : Icons.dark_mode_outlined)),
                              ),
                            ),
                          ),
                          AnimatedOpacity(
                            opacity: provider.mode == _LogMonitorMode.visible
                                ? 1.0
                                : (provider.mode == _LogMonitorMode.dim
                                    ? 0.3
                                    : 0.0),
                            duration: const Duration(milliseconds: 500),
                            child: StreamBuilder<FlutterErrorDetails>(
                              stream: _streamController.stream,
                              builder: (context, snapshot) {
                                return IgnorePointer(
                                  ignoring:
                                      provider.mode == _LogMonitorMode.visible
                                          ? false
                                          : true,
                                  child: Visibility(
                                    visible: snapshot.hasData,
                                    child: Container(
                                        height: screenSize.height / 3,
                                        width: screenSize.width - 60,
                                        margin: const EdgeInsets.only(top: 10),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.black.withOpacity(0.7),
                                        ),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "${snapshot.data?.exception}",
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.red,
                                                  decoration:
                                                      TextDecoration.none,
                                                ),
                                              ),
                                              Text(
                                                "${snapshot.data?.stack ?? ""}",
                                                style: const TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.white,
                                                  decoration:
                                                      TextDecoration.none,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : widget.child;
        },
      ),
    );
  }
}
