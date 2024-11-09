
## Log Monitor
The **Log Monitor** package for Flutter allows you to easily display real-time error logs as an overlay across all pages of your app. This is extremely useful for developers to monitor and debug issues while building and testing the app.
## Features

- Show error logs in a real-time overlay on all pages of the app.
- Live previews
- Helps in debugging and monitoring app performance without switching to the console.
- Easy to set up and use.


## Installation

To use the **Log Monitor** package in your Flutter project, follow these steps:
1.  Add the dependency to your *pubspec.yaml* file:
```yaml
dependencies:
    log_monitor: ^1.0.0
    
```
2. Install the package by running:
```bash
flutter pub get
```

## Usage/Examples
To use the Log Monitor, you simply need to wrap your MaterialApp widget with the LogMonitor widget. This will automatically display a real-time overlay of error logs.

```dart
import 'package:flutter/material.dart';
import 'package:log_monitor/log_monitor.dart';  // Import the package

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Wrap your app in the LogMonitor widget to enable live log overlay
      home: LogMonitor(
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Log Monitoring Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Simulate an error
            throw Exception('This is a test error!');
          },
          child: Text('Simulate Error'),
        ),
      ),
    );
  }
}

```


## Authors

- [Arnob Monir](https://github.com/arnobmonir)


## License

[MIT](https://choosealicense.com/licenses/mit/)
