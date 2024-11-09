library log_monitor;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:log_monitor/src/provider/log_monitor_provider.dart';
import 'package:provider/provider.dart';

class LogMonitor extends StatefulWidget {
  final Widget child;
  final bool isMonitor;

  const LogMonitor({
    super.key,
    required this.child,
    this.isMonitor = true,
  });

  @override
  State<LogMonitor> createState() => _LogMonitorState();
}

class _LogMonitorState extends State<LogMonitor> {
  Offset _position = const Offset(20, 100);
  Size screenSize = const Size(320, 480);
  final StreamController<FlutterErrorDetails> _streamController =
      StreamController<FlutterErrorDetails>();

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context) => LogMonitorProvider(),
      child: Consumer<LogMonitorProvider>(
        builder: (context, provider, providerchild) {
          FlutterError.onError = (FlutterErrorDetails details) {
            FlutterError.presentError(
                details); // This will print the error to the console
            if (widget.isMonitor) {
              _streamController.sink.add(details);
            }
          };
          return Stack(
            children: [
              Positioned.fill(
                child: widget.child ?? const Text('Something went wrong'),
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
                          } else if (_position.dx > (screenSize.width - 30)) {
                            _position =
                                Offset(screenSize.width - 30, _position.dy);
                          } else if (_position.dy < 30) {
                            _position = Offset(_position.dx, 30);
                          } else if (_position.dy > (screenSize.height - 30)) {
                            _position =
                                Offset(_position.dx, screenSize.height - 30);
                          } else {
                            _position += details.delta;
                          }
                        });
                      },
                      child: AnimatedOpacity(
                        opacity:
                            provider.mode == LogMonitorMode.visible ? 1.0 : 0.5,
                        duration: const Duration(milliseconds: 100),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                          child: Icon(provider.mode == LogMonitorMode.hide
                              ? Icons.vertical_align_bottom
                              : (provider.mode == LogMonitorMode.dim
                                  ? Icons.close
                                  : Icons.dark_mode_outlined)),
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: provider.mode == LogMonitorMode.visible
                          ? 1.0
                          : (provider.mode == LogMonitorMode.dim ? 0.3 : 0.0),
                      duration: const Duration(milliseconds: 500),
                      child: StreamBuilder<FlutterErrorDetails>(
                        stream: _streamController.stream,
                        builder: (context, snapshot) {
                          return IgnorePointer(
                            ignoring: provider.mode == LogMonitorMode.visible
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
                                    borderRadius: BorderRadius.circular(10),
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
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                        Text(
                                          "${snapshot.data?.stack ?? ""}",
                                          style: const TextStyle(
                                            fontSize: 11,
                                            color: Colors.white,
                                            decoration: TextDecoration.none,
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
          );
        },
      ),
    );
  }
}
