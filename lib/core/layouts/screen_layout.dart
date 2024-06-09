import 'package:flutter/material.dart';

class ScreenLayout extends StatefulWidget {
  final String appBarTitle;
  final Widget body;
  final List<Widget>? action;
  final bool? isLeadingNeeded;
  const ScreenLayout({super.key, required this.appBarTitle, required this.body, this.action, this.isLeadingNeeded});

  @override
  State<ScreenLayout> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        actions: widget.action,
        title: Text( widget.appBarTitle, ),
      ),
      body: widget.body,
    );
  }
}