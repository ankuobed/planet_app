import 'package:flutter/material.dart';

/// A PageView which creates Circular Scroll Effect.
class CircularPageView extends StatefulWidget {
  final PageController controller;
  final int itemCount;
  final List<Widget> items;

  ///Function to access the PageChanged status and returns currently Active Index
  final Function(int)? onPageChanged;

  ///Value to control the amount of circular effect you want to create.
  ///It accepts value between 0.0 and 1.0
  final double innerRadius;

  ///Value to control the amount of offset you want the widgets to move down
  ///Best values range (100 - 300)
  final double offset;

  const CircularPageView({
    Key? key,
    required this.controller,
    required this.itemCount,
    required this.items,
    this.onPageChanged,
    this.innerRadius = 0.5,
    this.offset = 150.0,
  }) : super(key: key);

  @override
  CircularPageViewState createState() => CircularPageViewState();
}

class CircularPageViewState extends State<CircularPageView> {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: widget.controller,
      itemCount: widget.itemCount,
      itemBuilder: (context, index) => _buildPage(
        index,
        widget.items[index],
      ),
      onPageChanged: widget.onPageChanged,
    );
  }

  Widget _buildPage(int index, Widget mainChild) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        double value = 1;
        if (widget.controller.position.haveDimensions) {
          value = widget.controller.page! - index;
          value = (1 - (value.abs() * widget.innerRadius)).clamp(0.0, 1.0);
          return Align(
            alignment: Alignment.center,
            child: Transform.translate(
              offset: Offset(
                0,
                -(Curves.ease.transform(value) * widget.offset),
              ),
              child: child,
            ),
          );
        } else {
          return Transform.translate(
            offset: Offset(
              0.0,
              -(Curves.ease.transform(
                      index == 0 ? value : value * widget.innerRadius) *
                  widget.offset),
            ),
            child: Align(
              alignment: Alignment.center,
              child: child,
            ),
          );
        }
      },
      child: mainChild,
    );
  }
}
