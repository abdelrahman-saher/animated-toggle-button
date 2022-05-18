library animatedtoggle;

import 'package:flutter/material.dart';

class AnimatedToggleButton extends StatefulWidget {
  final double? width;
  final double? height;
  final Duration? duration;
  final Color? onColor, offColor;
  Function(bool)? onToggle;
  AnimatedToggleButton({
    Key? key,
    this.height,
    this.width,
    this.duration,
    this.onToggle,
    this.onColor,
    this.offColor,
  }) : super(key: key);
  @override
  State<AnimatedToggleButton> createState() => _AnimatedToggleButtonState();
}

class _AnimatedToggleButtonState extends State<AnimatedToggleButton>
    with TickerProviderStateMixin {
  late double _height;
  late double _width;
  Color _color = Colors.grey;
  bool _resized = false;
  Alignment _alignment = Alignment.centerLeft;

  @override
  void initState() {
    _height = widget.height! - 5;
    _width = _height;
    _color = widget.offColor!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          child: Container(
            height: widget.height,
            width: widget.width,
            decoration: BoxDecoration(
                color: _color,
                borderRadius: BorderRadius.circular((_height + 5) / 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.5),
                    blurRadius: 2,
                    spreadRadius: 2,
                  )
                ]),
            padding: const EdgeInsets.all(2.5),
            child: Container(
              alignment: _alignment,
              child: AnimatedContainer(
                onEnd: () {
                  setState(() {
                    if (!_resized && _width == widget.width! - 5) {
                      _alignment = Alignment.centerRight;
                      _width = _height;
                      _resized = true;
                    } else if (_resized && _width == widget.width! - 5) {
                      _alignment = Alignment.centerLeft;
                      _width = _height;
                      _resized = false;
                    }
                  });
                },
                width: _width,
                height: _height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular((_height) / 2),
                ),
                duration: widget.duration!,
                alignment: Alignment.center,
              ),
            ),
          ),
          onTap: () {
            setState(() {
              widget.onToggle!(!_resized);
              if (!_resized && _width == _height) {
                _width = widget.width! - 5;
                _color = widget.onColor!;
              } else if (_resized && _width == _height) {
                _width = widget.width! - 5;
                _color = widget.offColor!;
              }
            });
          },
        ),
      ),
    );
  }
}
