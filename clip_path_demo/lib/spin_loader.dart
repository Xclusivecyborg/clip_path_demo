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
    _animation = Tween<double>(begin: 0.0, end: math.pi * 2).animate(
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
    final width = size.width;
    final height = size.height;
    final center = Offset(width / 2, height / 2);

    canvas.translate(center.dx, center.dy);
    const firstCircleOffset = Offset.zero;

    canvas.rotate(math.pi / 2);
    canvas.drawCircle(firstCircleOffset, height, firstCirclePaint);

    final arcRect = Rect.fromCircle(
      center: Offset.zero,
      radius: height * 1.2,
    );

    final arcPaint = Paint()
      ..color = radians < math.pi && radians < math.pi / 2
          ? Colors.blueAccent
          : radians < math.pi && radians > math.pi / 2
              ? Colors.purpleAccent
              : Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    const double startAngle = -math.pi / 2;
    const double sweepAngle = math.pi / 2;

    canvas.drawArc(arcRect, startAngle, sweepAngle, false, arcPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
