import 'package:flutter/material.dart';

class MyPath extends StatelessWidget {
  const MyPath({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClipPath(
        clipper: MyClipper(),
        child: Container(
          height: 400,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue, Colors.green],
            ),
          ),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final curvePath = Path();
    final firstLineOffset = Offset(0, size.height - 100);
    final givenPoint = Offset(size.width, size.height - 100);
    final controlPoint = Offset(size.width / 2, size.height + 40);

    //draw a line to height of the container minus 100 pixels without shifting it to the side of the screen
    curvePath.lineTo(firstLineOffset.dx, firstLineOffset.dy);

    //it draws a curve from our current point(size.height -100 ) to the given point
    curvePath.quadraticBezierTo(
      controlPoint.dx,
      controlPoint.dy,
      givenPoint.dx,
      givenPoint.dy,
    );

    //Draws a line from the edge of screen (topleft) to the other edge of the screen (top right)
    curvePath.lineTo(size.width, 0);
    curvePath.close();
    return curvePath;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    //should reclip is false because our widget is not being rebuilt
    return false;
  }
}
