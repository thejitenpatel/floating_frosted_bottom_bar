import 'package:flutter/material.dart';

class LogoList extends StatelessWidget {
  final ScrollController scrollController;

  const LogoList({Key? key, required this.scrollController}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemBuilder: (context, index) {
        return const Card(child: FittedBox(child: FlutterLogo()));
      },
    );
  }
}
