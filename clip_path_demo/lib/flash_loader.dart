import 'package:flutter/material.dart';
import 'dart:math' as math;

class FlashLoader extends StatefulWidget {
  const FlashLoader({Key? key}) : super(key: key);

  @override
  State<FlashLoader> createState() => _FlashLoaderState();
}

class _FlashLoaderState extends State<FlashLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(
          milliseconds: 2000,
        ));
    _animation =
        Tween<double>(begin: 0, end: math.pi + 0.2).animate(_controller)
          ..addListener(() => setState(() {
                if (AnimationStatus.completed == _animation.status) {
                  _controller.reverse();
                } else if (AnimationStatus.dismissed == _animation.status) {
                  _controller.forward();
                }
              }));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomPaint(
          painter: _FlashPainter(animation: _animation.value),
        ),
      ),
    );
  }
}

class _FlashPainter extends CustomPainter {
  final double animation;

  _FlashPainter({required this.animation});
  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final center = Offset(width / 2, height / 2);

    Shader shader = const LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.blueGrey,
        Colors.amber,
        Colors.red,
        Colors.blueAccent,
      ],
    ).createShader(const Rect.fromLTWH(-100, 30, 150, 0));
    canvas.translate(center.dx, center.dy);
    final paint = Paint()
      ..color = Colors.blueAccent
      ..strokeWidth = 10;

    final arcPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..shader = shader
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset.zero,
      Offset.fromDirection(math.pi + animation, 70),
      Paint()
        ..strokeWidth = 7
        ..strokeCap = StrokeCap.round
        ..shader = shader,
    );
    canvas.drawCircle(Offset.zero, 10, paint);

    final rect = Rect.fromCircle(center: Offset.zero, radius: 100);
    const startAngle = -math.pi;
    var sweepAngle = animation;
    canvas.drawArc(rect, startAngle, sweepAngle, false, arcPaint); 
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
