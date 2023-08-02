library widget_to_image;

export 'widget_to_image.dart';

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:convert_widget_to_image/widget_to_image_controller.dart';
import 'dart:ui' as ui;

class WidgetToImage {
  static Future<ui.Image> asDartUiImage(GlobalKey key) async {
    final WidgetToImageController controller = WidgetToImageController(key);
    return await controller.toDartUiImage();
  }

  static Future<ByteData> asByteData(GlobalKey key) async {
    final WidgetToImageController controller = WidgetToImageController(key);
    var image = await controller.toByteData();

    if (image != null) {
      return image;
    } else {
      throw Exception('A error happens while converting');
    }
  }

  static Future<Image> asImage(GlobalKey key) async {
    final WidgetToImageController controller = WidgetToImageController(key);
    return await controller.toImage();
  }

  static Future<Uint8List> asUint8List(GlobalKey key) async {
    final WidgetToImageController controller = WidgetToImageController(key);
    var image = await controller.toUint8List();

    if (image != null) {
      return image;
    } else {
      throw Exception('A error happens while converting');
    }
  }
}

// class WidgetToImage {
//   static Future<ui.Image> asDartUiImage(Widget widget) async {
//     final WidgetToImageController controller = WidgetToImageController(widget);
//     return await controller.toDartUiImage();
//   }

//   static Future<ByteData> asByteData(Widget widget) async {
//     final WidgetToImageController controller = WidgetToImageController(widget);
//     var image = await controller.toByteData();

//     if (image != null) {
//       return image;
//     } else {
//       throw Exception('A error happens while converting');
//     }
//   }

//   static Future<Image> asImage(Widget widget) async {
//     final WidgetToImageController controller = WidgetToImageController(widget);
//     return await controller.toImage();
//   }

//   static Future<Uint8List> asUint8List(Widget widget) async {
//     final WidgetToImageController controller = WidgetToImageController(widget);
//     var image = await controller.toUint8List();

//     if (image != null) {
//       return image;
//     } else {
//       throw Exception('A error happens while converting');
//     }
//   }
// }
