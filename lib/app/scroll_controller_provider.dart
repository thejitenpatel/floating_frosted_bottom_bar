import 'package:flutter/material.dart';

class BottomBarScrollControllerProvider extends InheritedWidget {
  final ScrollController scrollController;
  const BottomBarScrollControllerProvider({
    Key? key,
    required Widget child,
    required this.scrollController,
  }) : super(key: key, child: child);
  @override
  bool updateShouldNotify(BottomBarScrollControllerProvider oldWidget) =>
      scrollController != oldWidget.scrollController;
  static BottomBarScrollControllerProvider of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<BottomBarScrollControllerProvider>()!;
}
