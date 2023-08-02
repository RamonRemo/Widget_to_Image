A  simple package who convert widgets to image types;

## Features

Types Supported:

- Uint8List
- ByteData
- Image
- Dart:ui Image 

## Getting started

1. Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  widget_to_image: any
```

1. Get the package using your IDE's GUI or via command line with

```bash
$ pub get
```

1. Import the `widgets_to_image.dart` file in your app

```dart
import 'package:widget_to_image/widget_to_image.dart';
```

## Usage

1. First wrap you widget in a `RepaintBoundary()` and give him a `GobalKey()`

```dart
RepaintBoundary(
    key: key,
    child: ElevatedButton(
    style: ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12))),
        onPressed: () {},
        child: Text('Simple Button'),,
    ),
)
```
2. Then pass the key to the WidgetToImage selecting the constructor of type that you want

```dart
final dartUiImage = await WidgetToImage.asDartUiImage(key);
final byte = await WidgetToImage.asByteData(key);
final uint = await WidgetToImage.asUint8List(key);
final image = await WidgetToImage.asImage(key);
```

## Additional information

Feel free to do pull requests or ask for changes on issues(on gitHub). There is a simple example on the github.
