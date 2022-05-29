import 'package:flutter/material.dart';
import 'dart:math' as math;

class SpinLoader extends StatefulWidget {
  const SpinLoader({Key? key}) : super(key: key);

  @override
  State<SpinLoader> createState() => _SpinLoaderState();
}

class _SpinLoaderState extends State<SpinLoader> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: math.pi * 2).animate(
      _controller,
    )..addListener(() => setState(() {}));

    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Transform.rotate(
        angle: _animation.value,
        child: Center(
          child: CustomPaint(
            painter: _SpinLoaderPainter(
              radians: _animation.value,
            ),
            size: const Size(50, 50),
          ),
        ),
      ),
    );
  }
}

class _SpinLoaderPainter extends CustomPainter {
  _SpinLoaderPainter({required this.radians});
  final double radians;
  @override
  void paint(Canvas canvas, Size size) {
    //The paint for the inner circle
    final firstCirclePaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill
      ..shader = const LinearGradient(
        colors: [
          Colors.green,
          Colors.blueAccent,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromCircle(
        center: Offset.zero,
        radius: size.width / 2,
      ));

    //The width of the size of our canvas
    final width = size.width;

    //The height of the size of our canvas
    final height = size.height;

    //The center of our canvas i.e center of the screen
    final center = Offset(width / 2, height / 2);

    ///This translate method shifts the origin of
    ///the offset to the center of the screen
    canvas.translate(center.dx, center.dy);

    //The offset of the circle in the center of the screen
    const firstCircleOffset = Offset.zero;

    ///This draws the circle in the center of the screen
    canvas.drawCircle(firstCircleOffset, height * 0.7, firstCirclePaint);

    ///The rect used for our arcs
    ///Offset.zero means the center of the screen
    /// radius of height* 1.2 means we are giving it a size that's
    /// bigger than the height by 20%
    final arcRect = Rect.fromCircle(
      center: Offset.zero,
      radius: height * 1.2,
    );

    final arcPaint = Paint()
      ..color = radians < math.pi && radians < math.pi / 2
          ? Colors.blueAccent
          : radians < math.pi && radians > math.pi / 2
              ? Colors.purpleAccent
              : Colors.deepPurpleAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    final arcPaint2 = Paint()
      ..color = radians < math.pi && radians < math.pi / 2
          ? Colors.purpleAccent
          : radians < math.pi && radians > math.pi / 2
              ? Colors.deepPurpleAccent
              : Colors.blueAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    //Start angle means where the arc starts from
    //Sweep means how much of the arc we want to draw
    const double startAngle = -math.pi;
    const double sweepAngle = math.pi * 0.7;

    const double startAngle2 = -math.pi + math.pi;
    const double sweepAngle2 = math.pi * 0.7;

    canvas.drawArc(arcRect, startAngle, sweepAngle, false, arcPaint);
    canvas.drawArc(arcRect, startAngle2, sweepAngle2, false, arcPaint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
