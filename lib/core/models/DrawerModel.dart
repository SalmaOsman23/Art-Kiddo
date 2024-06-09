import 'package:flutter/material.dart';

class ColoredPoints{
   Offset? coloredPoints;
   Color? color; 
   ColoredPoints(this.color, this.coloredPoints);
}

class DrawerModel extends ChangeNotifier {
  List<ColoredPoints> points = [];
  Color selectedColor = Colors.black;
  List<int> lineStartIndices = [];

  void addPoints(Offset? point) {
    points.add(ColoredPoints(selectedColor, point));
    if(points.length ==1 || points[points.length - 2].coloredPoints == null){
      lineStartIndices.add(points.length - 1);
    }
    notifyListeners();
  }

  void undo() {
    if (points.isNotEmpty) {
      points.removeLast();
      notifyListeners();
    }
  }

  void clear() {
    points.clear();
      notifyListeners();
    
  }

  void changeColor(Color chosenColor) {
    selectedColor = chosenColor;
    notifyListeners();
  }
}


// class DrawerModel extends ChangeNotifier {
//   List<List<ColoredPoints>> lines = [];
//   Color selectedColor = Colors.black;

//   void addPoints(Offset? point) {
//     if (point != null) {
//       if (lines.isEmpty || lines.last.isNotEmpty) {
//         lines.add([]);
//       }
//       lines.last.add(ColoredPoints(selectedColor, point));
//       notifyListeners();
//     }
//   }

//   void undo() {
//     if (lines.isNotEmpty) {
//       if (lines.last.isNotEmpty) {
//         lines.last.removeLast();
//       } else {
//         lines.removeLast();
//       }
//       notifyListeners();
//     }
//   }

//   void clear() {
//     lines.clear();
//     notifyListeners();
//   }

//   void changeColor(Color chosenColor) {
//     selectedColor = chosenColor;
//     notifyListeners();
//   }
// }
