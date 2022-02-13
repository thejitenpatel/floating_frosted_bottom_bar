import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'scroll_controller_provider.dart';

class FrostedBottomBar extends StatefulWidget {
  final Widget Function(BuildContext context, ScrollController controller) body;
  final Widget child;
  final Color bottomBarColor;
  final double end;
  final double start;
  final double bottom;
  final Duration duration;
  final Curve curve;
  final double width;
  final BorderRadius borderRadius;
  final Alignment alignment;
  final Function()? onBottomBarShown;
  final Function()? onBottomBarHidden;
  final bool reverse;
  final bool scrollOpposite;
  final bool hideOnScroll;
  final StackFit fit;
  final double sigmaX;
  final double sigmaY;
  final double opacity;

  const FrostedBottomBar({
    required this.body,
    required this.child,
    this.bottomBarColor = Colors.black,
    this.end = 0,
    this.start = 2,
    this.bottom = 10,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.linear,
    this.width = 300,
    this.borderRadius = BorderRadius.zero,
    this.alignment = Alignment.bottomCenter,
    this.onBottomBarShown,
    this.onBottomBarHidden,
    this.reverse = false,
    this.scrollOpposite = false,
    this.hideOnScroll = true,
    this.fit = StackFit.loose,
    this.sigmaX = 10,
    this.sigmaY = 10,
    this.opacity = 0.5,
    Key? key,
  }) : super(key: key);

  @override
  _FrostedBottomBarState createState() => _FrostedBottomBarState();
}

class _FrostedBottomBarState extends State<FrostedBottomBar>
    with SingleTickerProviderStateMixin {
  ScrollController scrollBottomBarController = ScrollController();
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late bool isScrollingDown;
  late bool isOnTop;

  @override
  void initState() {
    isScrollingDown = widget.reverse;
    isOnTop = !widget.reverse;
    myScroll();
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset(0, widget.start),
      end: Offset(0, widget.end),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ))
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
    _controller.forward();
  }

  void showBottomBar() {
    if (mounted) {
      setState(() {
        _controller.forward();
      });
    }
    if (widget.onBottomBarShown != null) widget.onBottomBarShown!();
  }

  void hideBottomBar() {
    if (mounted && widget.hideOnScroll) {
      setState(
        () {
          _controller.reverse();
        },
      );
    }
    if (widget.onBottomBarHidden != null) widget.onBottomBarHidden!();
  }

  Future<void> myScroll() async {
    scrollBottomBarController.addListener(() {
      if (!widget.reverse) {
        if (scrollBottomBarController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          if (!isScrollingDown) {
            isScrollingDown = true;
            isOnTop = false;
            hideBottomBar();
          }
        }
        if (scrollBottomBarController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (isScrollingDown) {
            isScrollingDown = false;
            isOnTop = true;
            showBottomBar();
          }
        }
      } else {
        if (scrollBottomBarController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (!isScrollingDown) {
            isScrollingDown = true;
            isOnTop = false;
            hideBottomBar();
          }
        }
        if (scrollBottomBarController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          if (isScrollingDown) {
            isScrollingDown = false;
            isOnTop = true;
            showBottomBar();
          }
        }
      }
    });
  }

  @override
  void dispose() {
    scrollBottomBarController.removeListener(() {});
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: widget.fit,
      alignment: widget.alignment,
      children: [
        BottomBarScrollControllerProvider(
          scrollController: scrollBottomBarController,
          child: widget.body(context, scrollBottomBarController),
        ),
        Positioned(
          bottom: widget.bottom,
          child: SlideTransition(
            position: _offsetAnimation,
            child: ClipRRect(
              borderRadius: widget.borderRadius,
              child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: widget.sigmaX, sigmaY: widget.sigmaY),
                child: Opacity(
                  opacity: widget.opacity,
                  child: Container(
                    width: widget.width,
                    decoration: BoxDecoration(
                      color: widget.bottomBarColor,
                      borderRadius: widget.borderRadius,
                    ),
                    child: Material(
                      color: widget.bottomBarColor,
                      child: widget.child,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
