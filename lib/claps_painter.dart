import 'dart:ui';
import 'claps_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClapsPainter extends CustomPainter {
  final double step;
  final ClapsState state;

  final Color likeColor;
  final Color unLikeColor;

  ClapsPainter(this.step, this.state, {this.likeColor, this.unLikeColor});

  @override
  void paint(Canvas canvas, Size size) {
    switch (state) {
      case ClapsState.like:
        _paintLikeState(canvas, size, step, likeColor, unLikeColor);
        break;
      case ClapsState.unLike:
        _paintUnLikeState(canvas, size, step, unLikeColor, likeColor);
        break;
    }
  }

  @override
  bool shouldRepaint(ClapsPainter oldDelegate) => true;

  void _paintBackgroundState(
      Canvas canvas, Size size, double step, Paint unlikePaint) {
    final centerCirclePoint = Offset(size.width / 2, size.height / 2);
    final radius = size.height / 2 * step;

    canvas.drawCircle(centerCirclePoint, radius, unlikePaint);
  }

  void _paintHeart(Canvas canvas, Size size, double step, Paint likePaint) {
    final width = size.width * step / 2;
    final height = size.height * step / 2;
    final newHeight = 0.8 * height;
    final newWidth = 0.8 * width;

    final path = Path()
      ..moveTo(width / 2, height - newHeight)
      ..arcToPoint(
          Offset(width / 2 + newWidth / 2, height - newHeight + newHeight / 2),
          radius: Radius.circular(newHeight / 4),
          largeArc: true,
          clockwise: true)
      ..lineTo(width / 2, height)
      ..moveTo(width / 2, height - newHeight)
      ..arcToPoint(
          Offset(width / 2 - newWidth / 2, height - newHeight + newHeight / 2),
          radius: Radius.circular(newHeight / 4),
          largeArc: true,
          clockwise: false)
      ..lineTo(width / 2, height);

    final newPath = Path()
      ..addPath(
          path,
          Offset(height / 2 + (1 - step) * size.height / 2,
              width / 2 + (1 - step) * size.width / 2));

    canvas.drawPath(newPath, likePaint);
  }

  Paint _paintBuilder(Color color) => Paint()
    ..color = color
    ..style = PaintingStyle.fill;

  void _paintLikeState(
      Canvas canvas, Size size, double step, Color color, Color background) {
    if (step == 0) {
      _paintBackgroundState(canvas, size, 1, _paintBuilder(background));
      _paintHeart(canvas, size, 1, _paintBuilder(color));
    } else if (step > 0 && step < 0.5) {
      _paintBackgroundState(canvas, size, 1, _paintBuilder(background));
      _paintHeart(canvas, size, 2 * (0.5 - step), _paintBuilder(color));
    } else {
      _paintBackgroundState(canvas, size, 1, _paintBuilder(background));
      _paintBackgroundState(
          canvas, size, 2 * (step - 0.5), _paintBuilder(color));
      _paintHeart(canvas, size, 2 * (step - 0.5), _paintBuilder(background));
    }
  }

  void _paintUnLikeState(
      Canvas canvas, Size size, double step, Color color, Color background) {
    if (step == 0) {
      _paintBackgroundState(canvas, size, 1, _paintBuilder(color));
      _paintHeart(canvas, size, 1, _paintBuilder(background));
    } else if (step > 0 && step < 0.5) {
      _paintBackgroundState(canvas, size, 1, _paintBuilder(color));
      _paintBackgroundState(canvas, size, 2 * step, _paintBuilder(background));
      _paintHeart(canvas, size, 2 * (0.5 - step), _paintBuilder(background));
    } else {
      _paintBackgroundState(canvas, size, 1, _paintBuilder(background));
      _paintHeart(canvas, size, 2 * (step - 0.5), _paintBuilder(color));
    }
  }
}
