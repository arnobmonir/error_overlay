
## Error Overlay
The **Error Overlay** package for Flutter allows you to easily display real-time error logs as an overlay across all pages of your app. This is extremely useful for developers to monitor and debug issues while building and testing the app.
## Features

- Show error logs in a real-time overlay on all pages of the app.
- Live previews
- Helps in debugging and monitoring app performance without switching to the console.
- Easy to set up and use.
![screen_capture.gif](screenshots%2Fscreen_capture.gif)
![error_overlay_screen.png](screenshots%2Ferror_overlay_screen.png)


## Installation

To use the **Error Overlay** package in your Flutter project, follow these steps:
1.  Add the dependency to your *pubspec.yaml* file:
```yaml
dependencies:
  error_overlay: ^1.0.7
    
```
2. Install the package by running:
```bash
flutter pub get
```

## Usage/Examples
To use the Error Overlay, you simply need to wrap your MaterialApp widget with the ErrorOverlay widget. This will automatically display a real-time overlay of error logs.

```dart
import 'package:flutter/material.dart';
import 'package:error_overlay/error_overlay.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ErrorOverlay(child: MyHomePage()),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Wrap your prefer widget with ShowErrorOverlay to enable monitoring
        title: const ShowErrorOverlay(child: Text("Log Monitor")),
      ),
      body: Center(
        child: TextButton(
          child: const Text("Throw Exception"),
          onPressed: () {
            throw Exception("Test Exception");
          },
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

