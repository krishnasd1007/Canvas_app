import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() {

  runApp(Board());
}

class Draw{
  Offset point;
  Paint p;
  Draw({this.point,this.p});

}

class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  List<Draw> _points = <Draw>[];
  Color selectedColor;
  @override
  void initState() {
    super.initState();
    selectedColor = Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    void selectColor() {
      showDialog(
          context: context,
          child: AlertDialog(
            content: SingleChildScrollView(
              child: BlockPicker(
                pickerColor: selectedColor,
                onColorChanged: (color) {
                  this.setState(() {
                    selectedColor = color;
                  });
                },
              ),
            ),
          )
      );
    }
    return Scaffold(


      appBar: AppBar(
        title: Text("My Canvas"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 90),
        child: Container(
          color: Colors.white,
          child: GestureDetector(
            onPanDown: (DragDownDetails details) {
              this.setState(() {
                _points.add(Draw(
                    point: details.localPosition,
                    p: Paint()
                      ..strokeWidth = 5.0
                      ..color = selectedColor
                ));
              });
            },
            onPanUpdate: (DragUpdateDetails details) {
              this.setState(() {
                _points.add(Draw(
                    point: details.localPosition,
                    p: Paint()
                      ..strokeWidth = 5.0
                      ..color = selectedColor
                ));
              });
            },
            onPanEnd: (DragEndDetails details) => _points.add(null),
            child: new CustomPaint(
              painter: new FaceOutlinePainter(points: _points),
              size: Size.infinite,
            ),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(Icons.palette),
        onPressed: () {
          selectColor();
        },
      ),


    );

  }
}


class FaceOutlinePainter extends CustomPainter {
  List<Draw> points;
  Color color;
  FaceOutlinePainter({this.points,this.color});
  @override
  void paint(Canvas canvas,Size size) {

    for(int i=0; i <points.length-1;i++)
    {
      if(points[i] != null && points[i+1] !=null)
      {
        Paint paint = points[i].p;
        canvas.drawLine(points[i].point, points[i+1].point, paint);
      }
    }
  }
  @override
  bool shouldRepaint(FaceOutlinePainter oldDelegate) => oldDelegate.points != points;
}



