import 'claps_state.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClapsController extends ChangeNotifier {
  static const int durationDefault = 250; //duration for animation (millisec)
  static const double valueStart = 0.0; //start value for animation
  static const double valueEnd = 1.0; //end value for animation

  final AnimationController controller;

  ClapsState state = ClapsState.unLike;

  double get progress => controller.value;

  ClapsController({@required TickerProvider vsync, this.state})
      : controller = AnimationController(vsync: vsync) {
    controller.addListener(_onStateUpdate);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onStateUpdate() {
    notifyListeners();
  }

  void _startAnimation(double animationTo) {
    controller
      ..duration = const Duration(milliseconds: durationDefault)
      ..animateTo(animationTo);
    notifyListeners();
  }

  void setLikeState() {
    _startAnimation(valueStart);
    state = ClapsState.like;
  }

  void setUnLikeState() {
    _startAnimation(valueEnd);
    state = ClapsState.unLike;
  }
}
