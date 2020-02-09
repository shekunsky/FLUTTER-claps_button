library claps_button;

import 'package:flutter/material.dart';
import 'claps_state.dart';
import 'claps_painter.dart';
import 'claps_controler.dart';

typedef OnTapClapsed = Function(ClapsState clapsState);

class ClapsButton extends StatefulWidget {
  static const double widthDefault = 50; //default button width
  static const double heightDefault = 50; //default button height
  static const ClapsState stateDefault = ClapsState.unLike; //default state
  static const Color likeColorDefault = Color.fromARGB(255, 238, 118, 102);
  static const Color unLikeColorDefault = Color.fromARGB(255, 224, 224, 224);

  final double width;
  final double height;
  final ClapsState state;
  final Color likeColor;
  final Color unLikeColor;
  final OnTapClapsed onTapClapsed;

  ClapsButton({
    @required this.onTapClapsed,
    this.state = stateDefault,
    this.width = widthDefault,
    this.height = heightDefault,
    this.likeColor = likeColorDefault,
    this.unLikeColor = unLikeColorDefault,
  }) {
    assert(_colorIsValid(likeColor));
    assert(_colorIsValid(unLikeColor));
    assert(_sizeIsValid(width, height));
  }

  @override
  _ClapsState createState() => _ClapsState();

  bool _sizeIsValid(double width, double height) {
    assert(width != null, 'Width argument was null.');
    assert(height != null, 'Height argument was null.');
    assert(
        width == height, 'Width argument should be equally height argument.');
    return true;
  }

  bool _colorIsValid(Color color) {
    assert(color != null, 'Color argument was null.');
    return true;
  }
}

class _ClapsState extends State<ClapsButton>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  ClapsController _clapsController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _clapsController = ClapsController(vsync: this, state: widget.state)
      ..addListener(() => setState(() {}));
    _setClapsState();
  }

  @override
  void dispose() {
    _clapsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: GestureDetector(
        onTap: () {
          _updateClapsState();
          widget.onTapClapsed(_clapsController.state);
        },
        child: Container(
          height: widget.height,
          width: widget.width,
          child: CustomPaint(
            painter: ClapsPainter(
                _clapsController.progress, _clapsController.state,
                likeColor: widget.likeColor, unLikeColor: widget.unLikeColor),
          ),
        ),
      ),
    );
  }

  void _updateClapsState() {
    if (_clapsController.state == ClapsState.like) {
      _clapsController.setUnLikeState();
    } else {
      _clapsController.setLikeState();
    }
    setState(() {});
  }

  void _setClapsState() {
    if (_clapsController.state == ClapsState.like) {
      _clapsController.setLikeState();
    } else {
      _clapsController.setUnLikeState();
    }
    setState(() {});
  }
}
