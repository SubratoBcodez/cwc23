import 'package:cwc23/bcodez/color.dart';
import 'package:cwc23/bcodez/widget.dart';
import 'package:cwc23/views/matches.dart';
import 'package:flutter/material.dart';

class FixtureScreen extends StatefulWidget {
  @override
  State<FixtureScreen> createState() => _FixtureScreenState();
}

class _FixtureScreenState extends State<FixtureScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "MATCHES",
      ),
      backgroundColor: AppColor.whiteclr2,
      body: MatchesScreen(),
    );
  }
}
