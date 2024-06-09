import 'dart:developer';
import 'dart:ui';

import 'package:artkiddo/core/layouts/screen_layout.dart';
import 'package:artkiddo/core/models/DrawerModel.dart';
import 'package:artkiddo/core/utilis/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

class DrawScreen extends StatefulWidget {
  const DrawScreen({super.key});

  @override
  State<DrawScreen> createState() => _DrawScreenState();
}

class _DrawScreenState extends State<DrawScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
        appBarTitle: AppStrings.draw,
        action: [
          IconButton(
              onPressed: () {
                context.read<DrawerModel>().undo();
              },
              icon: const Icon(Icons.undo_rounded)),
          IconButton(
              onPressed: () {
                context.read<DrawerModel>().clear();
              },
              icon: const Icon(Icons.clear_rounded)),
          IconButton(
              onPressed: () {
                pickColor(context);
              },
              icon: const Icon(Icons.color_lens_outlined))
        ],
        body: GestureDetector(
          onPanUpdate: (details) {
          log("onUpdate: ${details.localPosition}");
          context.read<DrawerModel>().addPoints(details.localPosition);
        }, onPanEnd: (details) {
          log("onEnd: OnEnd");
          context.read<DrawerModel>().addPoints(null);
        }, child: Consumer<DrawerModel>(
          builder: (context, model, child) {
            return CustomPaint(
              painter: MyPainter(points: model.points, color: model.selectedColor, strokeWidth: 4.0),
              child: Container(
              ),
            );
          },
        )));
  }

  void pickColor(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(AppStrings.pickColor),
            content: SingleChildScrollView(
              child: BlockPicker(
                  pickerColor: context.read<DrawerModel>().selectedColor,
                  onColorChanged: (color) {
                    context.read<DrawerModel>().changeColor(color);
                  }),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(AppStrings.choose),
              )
            ],
          );
        });
  }
}

class MyPainter extends CustomPainter {
  final List<ColoredPoints?> points;
  final Color color;
  final double strokeWidth;

  MyPainter(
      {super.repaint,
      required this.points,
      required this.color,
      required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < points.length - 1; i++) {
    Paint paint = Paint()
      ..color = points[i]!.color!
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    for (int i = 0; i < points.length - 1; i++) {
    //If both points[i] and points[i + 1] are not null, a line is drawn between them using canvas.drawLine.
      if (points[i] != null && points[i]!.coloredPoints != null && points[i + 1] != null && points[i + 1]!.coloredPoints != null) {
        canvas.drawLine(points[i]!.coloredPoints!, points[i + 1]!.coloredPoints!, paint);
      } else if (points[i] != null && points[i + 1] == null) {
        // If points[i] is not null but points[i + 1] is null, it means there's a break in the drawing,
        canvas.drawPoints(PointMode.points, [points[i]!.coloredPoints!], paint);
      }
    }
  }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}



// class MyPainter extends CustomPainter {
//   final List<List<ColoredPoints>> lines;
//   final double strokeWidth;

//   MyPainter({required this.lines, required this.strokeWidth});

//   @override
//   void paint(Canvas canvas, Size size) {
//     for (final line in lines) {
//       if (line.isNotEmpty) {
//         Paint paint = Paint()
//           ..color = line.first.color!
//           ..strokeCap = StrokeCap.round
//           ..strokeWidth = strokeWidth;

//         for (int i = 0; i < line.length - 1; i++) {
//           if (line[i].coloredPoints != null && line[i + 1].coloredPoints != null) {
//             canvas.drawLine(line[i].coloredPoints!, line[i + 1].coloredPoints!, paint);
//           } else if (line[i].coloredPoints != null && line[i + 1].coloredPoints == null) {
//             canvas.drawPoints(PointMode.points, [line[i].coloredPoints!], paint);
//           }
//         }
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }
