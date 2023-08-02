// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class WidgetToImageController {
  // final Widget widget;
  late ui.Image _imageAsDartUiImage;
  late ByteData? _imageAsByteData;
  late Image _image;
  late Uint8List? _imageAsUint8list;
  late RenderRepaintBoundary? _boundary;
  final GlobalKey key;

  WidgetToImageController(
    this.key,
  );

  createPaint(
    GlobalKey key,
    // {Alignment alignment = Alignment.center,
    // Size size = const Size(double.maxFinite, double.maxFinite),
    // double devicePixelRatio = 1.0,
    // double pixelRatio = 1.0}
  ) async {
    // final widgetAsRepaintBoundary = RepaintBoundary(
    //   child: widget,
    //   key: key,
    // );

    _boundary =
        key.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    if (_boundary != null) {
      // Ensure that the widget is actually rendered on the screen
      key.currentContext?.visitChildElements((element) {
        final renderObject = element.renderObject;
        if (renderObject is RenderRepaintBoundary) {
          // Trigger a repaint of the RenderRepaintBoundary
          renderObject.markNeedsPaint();
        }
      });

      // Wait for the next frame to ensure that the repaint is complete
      await Future.delayed(Duration(milliseconds: 200));

      // Convert the widget to an image
      _imageAsDartUiImage = await _boundary!.toImage(pixelRatio: 6);
    }

    // await toDartUiImage(boundary);

    // await toByteData();

    // toUint8List();

    // toImage();
    // try {
    //   RenderRepaintBoundary repaintBoundary = RenderRepaintBoundary();
    //   // RenderView renderView = RendererBinding.instance.renderView;
    //   RenderView renderView = RenderView(
    //     child: RenderPositionedBox(
    //       alignment: alignment,
    //       child: repaintBoundary,
    //     ),
    //     configuration: ViewConfiguration(
    //       size: size,
    //       devicePixelRatio: devicePixelRatio,
    //     ),
    //     view: RendererBinding.instance.platformDispatcher.views.first,
    //   );

    //   PipelineOwner pipelineOwner = PipelineOwner();
    //   pipelineOwner.rootNode = renderView;
    //   renderView.prepareInitialFrame();

    //   BuildOwner buildOwner = BuildOwner(focusManager: FocusManager());
    //   RenderObjectToWidgetElement rootElement = RenderObjectToWidgetAdapter(
    //     container: repaintBoundary,
    //     child: widget,
    //   ).attachToRenderTree(buildOwner);
    //   buildOwner.buildScope(rootElement);
    //   buildOwner.finalizeTree();

    //   pipelineOwner.flushLayout();
    //   pipelineOwner.flushCompositingBits();
    //   pipelineOwner.flushPaint();

    //   _imageAsDartUiImage =
    //       await repaintBoundary.toImage(pixelRatio: pixelRatio);
    // } catch (e) {
    //   print(e);
    // }
  }

  Future<Image> toImage() async {
    await toUint8List();
    if (_imageAsUint8list != null) {
      return Image.memory(_imageAsUint8list!);
    } else {
      throw Exception('A error happens while converting');
    }
  }

  Future<Uint8List?> toUint8List() async {
    await toByteData();
    _imageAsUint8list = _imageAsByteData?.buffer.asUint8List();
    return _imageAsUint8list;
  }

  Future<ByteData?> toByteData() async {
    await toDartUiImage();
    _imageAsByteData =
        await _imageAsDartUiImage.toByteData(format: ui.ImageByteFormat.png);
    return _imageAsByteData;
  }

  Future<ui.Image> toDartUiImage() async {
    await createPaint(key);

    if (_boundary != null) {
      _imageAsDartUiImage = await _boundary!.toImage(pixelRatio: 6);
    } else {
      _boundary =
          key.currentContext?.findRenderObject() as RenderRepaintBoundary?;

      if (_boundary != null) {
        // Ensure that the widget is actually rendered on the screen
        key.currentContext?.visitChildElements((element) {
          final renderObject = element.renderObject;
          if (renderObject is RenderRepaintBoundary) {
            // Trigger a repaint of the RenderRepaintBoundary
            renderObject.markNeedsPaint();
          }
        });

        await Future.delayed(Duration(milliseconds: 200));
      }

      _imageAsDartUiImage = await _boundary!.toImage(pixelRatio: 6);
    }

    return _imageAsDartUiImage;
  }
}
